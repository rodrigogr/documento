import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AssembleiaComponent } from './assembleia.component';

describe('AssembleiaComponent', () => {
  let component: AssembleiaComponent;
  let fixture: ComponentFixture<AssembleiaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AssembleiaComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AssembleiaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
