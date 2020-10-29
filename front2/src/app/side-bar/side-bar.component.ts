import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
declare var $;
@Component({
  selector: 'app-side-bar',
  templateUrl: './side-bar.component.html',
  styleUrls: ['./side-bar.component.scss']
})
export class SideBarComponent implements OnInit {

  constructor(private route: Router) { }
  $ = $;

 
  ngOnInit() {
   // $(`#${this.route.url.split('/')[1]}`).fadeToggle("fast", "linear");
  }
  
}