import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { HomeComponent } from './home/home.component';
import { RoutesApp } from './app.routes';
import { SideBarComponent } from './side-bar/side-bar.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    SideBarComponent
  ],
  imports: [
    BrowserModule,
    RoutesApp
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
