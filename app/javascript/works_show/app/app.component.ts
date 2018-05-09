import { Component, OnInit } from '@angular/core';
import { WorksService } from './works.services';
import { CustomFunctions } from '../custom_functions';
import worksHTML from './templates/works.html';
import { Work } from './work';

@Component({
  selector: 'works-show',
  template: worksHTML,
  providers: [WorksService, CustomFunctions]

})
export class AppComponent implements OnInit {
  works: Work[];

  constructor(
    private service: WorksService,
    private custFuncs: CustomFunctions
  ) { } 

  ngOnInit() {
    this.service.getWorks().subscribe(works => this.works = works);
  }
}
