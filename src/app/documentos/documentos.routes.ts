import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Injectable } from '@angular/core';
import { CanActivate, RouterStateSnapshot, ActivatedRouteSnapshot, Router } from '@angular/router'
import { Observable } from 'rxjs/Observable';

import { DocumentosComponent } from './documentos/documentos.component';

const appRoutes: Routes = [
	{
		path: '',
		component: DocumentosComponent
	}
];

export const RoutesApp: ModuleWithProviders = RouterModule.forChild(appRoutes);