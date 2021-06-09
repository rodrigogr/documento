<?php
namespace App\Models\Reservas;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Reserva extends Model
{
    protected $table = 'reserva';
    protected $fillable = [
        'id_local_reservavel',
        'data',
        'id_periodo',
        'status',
        'id_imovel',
        'id_pessoa',
        'obs',
        'autor',
        'created_at'
    ];
    public $timestamps = true;

    public static function allCompleto()
    {
        return self::with(['localReservavel' => function ($q) {
            $q->join('bioacesso_portaria.localidades','localidades.id','=','local_reservavel.id_localidade');
            $q->select('localidades.descricao as localidade','local_reservavel.*');
        }])
            ->with(['periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->get();
    }

    public static function completoByData($data)
    {
        return self::where('data', $data)
            ->select('reserva.*')
            ->join('periodo_local_reservavel as plr','plr.id','reserva.id_periodo')
            ->with(['periodoLocalReservavel','localReservavel','imovel','pessoa'])
            ->orderBy('plr.hora_ini')
            ->get();
    }

    // public static function aprovacoes($data, $localReservavel = '', $localidade = '', $status = 'pendente')
    public static function aprovacoes($filtros)
    {
        $data = $filtros["data"];
        $status = $filtros["status"];
        $localReservavel = $filtros["localReservavel"];
        $localidade = $filtros["localidade"];

        //$usuario = \Auth::user();

        $busca = PeriodoLocalReservavel::join('reserva as r', function ($q) use($data, $status) {
            if (!empty($data) && $data != 'todos') {
                $q->on('r.data', \DB::raw("'" . $data . "'"));
            } elseif (!empty($data) && $data == 'todos') {
                if ($status == 'recusada') {
                    $q->on('r.data', '>=', \DB::raw("DATE_SUB(CURDATE(), INTERVAL 7 DAY)"));
                } else {
                    $q->on('r.data', '>=', \DB::raw("CURDATE()"));
                }
            }
            $q->on('r.id_periodo','periodo_local_reservavel.id');
            $q->where('r.status', $status);
        });

        if ($localidade) {
            $busca = $busca->join('local_reservavel as lr', function ($x) use($localidade) {
                $x->on('lr.id', 'periodo_local_reservavel.id_local_reservavel');
                $x->where('lr.id_localidade',$localidade);
            });
        }
        if ($localReservavel) {
            $busca = $busca->join('local_reservavel as lr', function ($x) use($localReservavel) {
                $x->on('lr.id', 'periodo_local_reservavel.id_local_reservavel');
                $x->where('lr.id',$localReservavel);
            });
        }

        $busca = $busca->leftJoin('bioacesso_portaria.pessoa as p', function ($q) {
            $q->on('r.autor','p.id');
        });

        $result = $busca->with(['imovel','pessoa','diaInativo'])
        ->with(['localReservavel' => function ($q) {
            $q->join('bioacesso_portaria.localidades','localidades.id','=','local_reservavel.id_localidade');
            $q->select('bioacesso_portaria.localidades.descricao as localidade','local_reservavel.*');
        }])
//        ->where('periodo_local_reservavel.dia_semana', $dia_semana)
        ->orderBy('r.data')
        ->orderBy('periodo_local_reservavel.hora_ini')
        ->select('periodo_local_reservavel.*',
            'r.id as idReserva',
            'r.data',
            \DB::raw('date_format(r.data, "%d/%m/%Y") as data_formatada'),
            \DB::raw("(CASE dayofweek(r.data)
               when 1 then 'Domingo'
               when 2 then 'Segunda-feira'
               when 3 then 'Terça-feira'
               when 4 then 'Quarta-feira'
               when 5 then 'Quinta-feira'
               when 6 then 'Sexta-feira'
               when 7 then 'Sábado' END) AS dia_semana"),
            \DB::raw('date_format(periodo_local_reservavel.hora_ini,"%H:%i") as hora_ini'),
            \DB::raw('date_format(periodo_local_reservavel.hora_fim,"%H:%i") as hora_fim'),
            'r.id_imovel as reserva_idImovel',
            'r.id_pessoa as reserva_idPessoa',
            'r.status as reserva_status',
            'r.id_imovel',
            'r.id_pessoa',
            'r.updated_at',
            'r.obs',
            'r.autor',
            'p.nome as autor')
        ->get();

        return $result;
    }

    public static function completoByImovel($idImovel)
    {
        return self::with(['periodoLocalReservavel' => function ($q) {
                $q->select('id',
                    'id_local_reservavel',
                    'dia_semana',
                    \DB::raw('date_format(hora_ini,"%H:%i") as hora_ini'),
                    \DB::raw('date_format(hora_fim,"%H:%i") as hora_fim'),
                    'valor');
            }])
            ->with(['localReservavel' => function ($q) {
                $q->join('bioacesso_portaria.localidades','localidades.id','=','local_reservavel.id_localidade');
                $q->select('localidades.descricao as localidade','local_reservavel.*');
            }])
            ->with(['imovel','pessoa','diaInativo'])
            ->where('id_imovel', $idImovel)
            ->get();
    }

    public static function completoByStatus($status)
    {
        return self::with(['localReservavel','periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->where('status', $status)
            ->get();
    }

    public static function simples($id)
    {
        return self::where('id',$id)
            ->get();
    }

    public static function completoById($id)
    {
        return self::with(['localReservavel','periodoLocalReservavel','imovel','pessoa','diaInativo'])
            ->where('id', $id)
            ->get();
    }

    public function recusadas()
    {
        return PeriodoLocalReservavel::join('reserva as r', function ($q) {
            $q->on('r.id_periodo','periodo_local_reservavel.id');
            $q->where('r.status','recusada');
        })
            ->with(['imovel','pessoa','diaInativo'])
            ->with(['localReservavel' => function ($q) {
                $q->join('bioacesso_portaria.localidades','localidades.id','=','local_reservavel.id_localidade');
                $q->select('bioacesso_portaria.localidades.descricao as localidade','local_reservavel.*');
            }])
            ->orderBy('r.data','desc')
            ->select('periodo_local_reservavel.*',
                'r.id as idReserva',
                'r.data',
                \DB::raw('date_format(periodo_local_reservavel.hora_ini,"%H:%i") as hora_ini'),
                \DB::raw('date_format(periodo_local_reservavel.hora_fim,"%H:%i") as hora_fim'),
                'r.id_imovel as reserva_idImovel',
                'r.id_pessoa as reserva_idPessoa',
                'r.status as reserva_status',
                'r.id_imovel',
                'r.id_pessoa')
            ->get();
    }

    public static function deleteByLocal($id) {
        return self::where('id_local_reservavel', $id)->delete();
    }

    public static function verificaReserva($id_periodo, $data)
    {
        return self::where(['id_periodo' => $id_periodo, 'data' => $data])
            ->get();
    }

    public static function saveReservaRecusada(Reserva $reserva)
    {
        DB::table('reserva')->insert([
            'id_local_reservavel' => $reserva->id_local_reservavel,
            'id_periodo' => $reserva->id_periodo,
            'data' => $reserva->data,
            'id_imovel' => $reserva->id_imovel,
            'id_pessoa' => $reserva->id_pessoa,
            'status' => $reserva->status,
            'created_at' => $reserva->created_at,
            'updated_at' => date('Y-m-d H:i:s'),
            'obs' => $reserva->obs,
            'autor' => $reserva->autor
        ]);
        $reserva->delete();
    }

    public static function getEventosCalendario($data_inicio, $data_fim, $id_local)
    {
        $dados = self::from('reserva as r')
            ->whereBetween('r.data', [$data_inicio, $data_fim])
            ->where('r.id_local_reservavel', $id_local)
            ->join('bioacesso_portaria.pessoa as p', 'p.id', 'r.id_pessoa')
            ->join('periodo_local_reservavel as plr', 'plr.id', 'r.id_periodo')
            ->select(DB::raw("concat(date_format(plr.hora_ini,'%H:%i'), ' ', p.nome) as title"),
                DB::raw('r.data as start'),
                DB::raw("if (r.status = 'pendente', '#F2C94C' , '') as color")
            )
            ->get();

        return $dados;
    }

    public static function historicoUsuario($idUsuario)
    {
        return self::where('id_pessoa', $idUsuario)
            ->with('periodoLocalReservavel')
            ->with(['pessoa' => function($q) {
                    $q->select('id','nome','url_foto');
                }])
            ->with(['imovel' => function($q) {
                    $q->join('localidades as lo', 'lo.id', 'imovel.idLocalidade');
                    $q->select('imovel.id','imovel.quadra','imovel.lote','imovel.logradouro','lo.descricao');
                }])
            ->get();
    }

    ## Relacionamentos ##

    public function localReservavel()
    {
        return $this->belongsTo('App\Models\Reservas\LocalReservavel', 'id_local_reservavel');
    }

    public function periodoLocalReservavel()
    {
        return $this->belongsTo('App\Models\Reservas\PeriodoLocalReservavel', 'id_periodo');
    }

    public function imovel()
    {
        return $this->belongsTo('App\Models\Imovel', 'id_imovel');
    }

    public function pessoa()
    {
        return $this->belongsTo('App\Models\Pessoa', 'id_pessoa');
    }

    public function diaInativo()
    {
        return $this->hasMany('App\Models\Reservas\DiaInativoLocalReservavel','id_local_reservavel','id_local_reservavel');
    }

    public function localidade()
    {
        return $this->belongsTo('App\Models\Localidade', 'id_localidade');
    }
}