import { Component, OnInit } from '@angular/core';
declare const $;

@Component({
  selector: 'app-assembleia-form',
  templateUrl: './form.component.html',
  styleUrls: ['./form.component.scss']
})
export class FormComponent implements OnInit {

  constructor() { }
  $ = $;
  ngOnInit() {
  }

  save () {
    this.$('app-assembleia-form').modal('hide');
  }
}
