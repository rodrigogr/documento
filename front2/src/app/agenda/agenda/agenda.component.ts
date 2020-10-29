import { Component, OnInit } from '@angular/core';
declare const $;
@Component({
  selector: 'app-agenda',
  templateUrl: './agenda.component.html',
  styleUrls: ['./agenda.component.scss']
})
export class AgendaComponent implements OnInit {
  $ = $;
  constructor() { }

  ngOnInit() {
  }

}
