import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AssembleiaComponent } from './assembleia/assembleia.component';
import { AssembleiaDetalheComponent } from './detalhe/detalhe.component';
import { RoutesApp } from './assembleias.routes';
import { FormComponent } from './form/form.component';

@NgModule({
  imports: [
    CommonModule,
    RoutesApp
  ],
  declarations: [AssembleiaComponent, FormComponent, AssembleiaDetalheComponent]
})
export class AssembleiasModule { }
