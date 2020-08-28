import { Component, OnInit } from '@angular/core';
declare const $;
@Component({
  selector: 'app-documentos',
  templateUrl: './documentos.component.html',
  styleUrls: ['./documentos.component.scss']
})
export class DocumentosComponent implements OnInit {
  $ = $;
  constructor() { }

  ngOnInit() {
  }

}
