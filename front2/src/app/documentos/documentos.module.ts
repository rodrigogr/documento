import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { DocumentosComponent } from './documentos/documentos.component';
import { RoutesApp } from './documentos.routes';
import { FormComponent } from './form/form.component';
@NgModule({
  imports: [
    CommonModule,
    RoutesApp
  ],
  declarations: [DocumentosComponent, FormComponent]
})
export class DocumentosModule { }
