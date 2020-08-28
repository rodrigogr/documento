import { Component, OnInit } from '@angular/core';
import { Router, NavigationStart } from '@angular/router';
import 'rxjs/Rx';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {

  constructor(public route: Router) { }

  routeModuleName;

  ngOnInit() {
    this.routeModuleName = this.route.url.split('/')[1];
    this.route.events
      .filter(event => event instanceof NavigationStart)
      .subscribe((x: any) => this.routeModuleName = x.url.split('/')[1]);
  }

}
