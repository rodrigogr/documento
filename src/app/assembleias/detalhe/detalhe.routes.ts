import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Injectable } from '@angular/core';
import { CanActivate, RouterStateSnapshot, ActivatedRouteSnapshot, Router } from '@angular/router'
import { Observable } from 'rxjs/Observable';

import { AssembleiaDetalheComponent } from './detalhe.component';

const appRoutes: Routes = [
	{
		path: '',
		component: AssembleiaDetalheComponent,
		children: [
			{
				path: 'edit',
				loadChildren: './detalhe/detalhe.module#AssembleiaDetalheModule'
			}
		]
	}
];

export const RoutesApp: ModuleWithProviders = RouterModule.forChild(appRoutes);