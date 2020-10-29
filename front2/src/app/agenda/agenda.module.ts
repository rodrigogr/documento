import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AgendaComponent } from './agenda/agenda.component';
import { RoutesApp } from './agenda.routes';
import { FormComponent } from './form/form.component';
@NgModule({
  imports: [
    CommonModule,
    RoutesApp
  ],
  declarations: [AgendaComponent, FormComponent]
})
export class AgendaModule { }
