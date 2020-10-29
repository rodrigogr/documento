import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AssembleiaDetalheComponent } from './detalhe.component';

import { RoutesApp } from '../assembleias.routes';


@NgModule({
  imports: [
    CommonModule,
    RoutesApp
  ],
  declarations: [AssembleiaDetalheComponent]
})
export class AssembleiasModule { }
