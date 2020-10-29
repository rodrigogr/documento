import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Injectable } from '@angular/core';
import { CanActivate, RouterStateSnapshot, ActivatedRouteSnapshot, Router } from '@angular/router'
import { Observable } from 'rxjs/Observable';

import { AssembleiaComponent } from './assembleia/assembleia.component';
import { AssembleiaDetalheComponent } from './detalhe/detalhe.component';

const appRoutes: Routes = [
	{
		path: '',
		component: AssembleiaComponent,
	},
	{
		path: 'detalhes/:id',
		component: AssembleiaDetalheComponent
	}
];

export const RoutesApp: ModuleWithProviders = RouterModule.forChild(appRoutes); 