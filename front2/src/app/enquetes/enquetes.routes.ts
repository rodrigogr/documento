import { ModuleWithProviders } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { Injectable } from '@angular/core';
import { CanActivate, RouterStateSnapshot, ActivatedRouteSnapshot, Router } from '@angular/router'
import { Observable } from 'rxjs/Observable';

import { EnqueteComponent } from './enquete/enquete.component';

const appRoutes: Routes = [
	{
		path: '',
		component: EnqueteComponent
	}
];

export const RoutesApp: ModuleWithProviders = RouterModule.forChild(appRoutes);