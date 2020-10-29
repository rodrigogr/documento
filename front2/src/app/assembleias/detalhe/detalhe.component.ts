import { Component, OnInit } from '@angular/core';
declare const $;

@Component({
  selector: 'app-assembleia-detalhe',
  templateUrl: './detalhe.component.html',
  styleUrls: ['./detalhe.component.scss']
})
export class AssembleiaDetalheComponent implements OnInit {

  constructor() { }
  $ = $;
  ngOnInit() {
  }

  save () {
    this.$('app-assembleia-detalhe').modal('hide');
  }
}
