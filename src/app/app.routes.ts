import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Injectable } from '@angular/core';
import { CanActivate, RouterStateSnapshot, ActivatedRouteSnapshot, Router } from '@angular/router'
import { Observable } from 'rxjs/Observable';

import { HomeComponent } from './home/home.component';

const appRoutes: Routes = [
	{
		path: '',
		component: HomeComponent,
		children: [
			{
				path: 'enquetes',
				loadChildren: './enquetes/enquetes.module#EnquetesModule'
			}, {
				path: 'agenda',
				loadChildren: './agenda/agenda.module#AgendaModule'
			}, {
				path: 'documentos',
				loadChildren: './documentos/documentos.module#DocumentosModule'
			}
		]
	},
	{ path: '', redirectTo: '', pathMatch: 'full' }
];

export const RoutesApp: ModuleWithProviders = RouterModule.forRoot(appRoutes, { useHash: false });