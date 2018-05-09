import { Component, OnInit } from '@angular/core';
import { WorksService } from './works.services';
import { Work } from './work';

@Component({
  selector: 'works-show',
  template: `<div *ngFor="let work of works">{{work.title}}</div>`,
  providers: [WorksService]

})
export class AppComponent implements OnInit {
  works: Work[];

  constructor(private service: WorksService) { }

  ngOnInit() {
    this.service.getWorks().subscribe(works => this.works = works);
  }
}
