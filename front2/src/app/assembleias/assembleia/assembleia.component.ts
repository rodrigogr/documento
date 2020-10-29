import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
declare const $;
@Component({
  selector: 'app-assembleia',
  templateUrl: './assembleia.component.html',
  styleUrls: ['./assembleia.component.scss']
})
export class AssembleiaComponent implements OnInit {
  constructor(
    private router: Router,
    private route: ActivatedRoute,
  ) { }
  $ = $;

  assembleias = [
    {id:1,titulo:'Assembleia Geral Extraordinária', status: 'Aberto para votação', periodo:'22/07/2020 das 18:00 às 22:00', periodo_votacao:'até 23/07/2020 às 22:00', local: 'Online' },
    {id:2,titulo:'Assembleia Geral Ordinária', status: 'Agendado', periodo:'22/07/2020 das 18:00 às 22:00', periodo_votacao:'até 23/07/2020 às 22:00', local: 'Online' },
    {id:3,titulo:'Assembleia Geral Ordinária', status: 'Ecerrada', periodo:'22/07/2020 das 18:00 às 22:00', periodo_votacao:'até 23/07/2020 às 22:00', local: 'Online' },
    {id:4,titulo:'Assembleia Geral de Instalação', status: 'Ecerrada', periodo:'22/07/2020 das 18:00 às 22:00', periodo_votacao:'até 23/07/2020 às 22:00', local: 'Auditório e Online' }
  ];

  ngOnInit() {
  };

   getAssembleias() { 
     
   };


  navigateToDetalhe(id: number)
  {
console.log(id);
    this.router.navigate(['assembleias/detalhes', id])
      .then(nav =>
      {
        window.location.reload();
      });
  }
}