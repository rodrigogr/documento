import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EnqueteComponent } from './enquete/enquete.component';

import { RoutesApp } from './enquetes.routes';
import { FormComponent } from './form/form.component';

@NgModule({
  imports: [
    CommonModule,
    RoutesApp
  ],
  declarations: [EnqueteComponent, FormComponent]
})
export class EnquetesModule { }
