import { Component, OnInit } from '@angular/core';
import { WorksService } from './works.services';
import worksTemplate from './works.html';
import { Work } from './work';

@Component({
  selector: 'works-show',
  template: worksTemplate,
  providers: [WorksService]

})
export class AppComponent implements OnInit {
  works: Work[];

  constructor(private service: WorksService) { }

  ngOnInit() {
    this.service.getWorks().subscribe(works => this.works = works);
  }
}
