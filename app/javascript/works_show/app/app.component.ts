import { Component, OnInit, AfterViewChecked } from '@angular/core';
import { WorksService } from './works.services';
import { CustomFunctions } from '../custom_functions';
import { Gridify } from '../gridify';
import worksHTML from './templates/works.html';
import { Work } from './work';


@Component({
  selector: 'works-show',
  template: worksHTML,
  providers: [WorksService, CustomFunctions, Gridify]

})
export class AppComponent implements OnInit {
  works: Work[];

  constructor(
    private service: WorksService,
    private custFuncs: CustomFunctions,
    private gridify: Gridify
  ) { } 

  ngOnInit() {
    this.service.getWorks().subscribe(works => this.works = works);
  }

  ngAfterViewChecked() {
    var first_run = true;
    if (first_run) {
      let selector = document.querySelector('.read-grid');
      this.gridify.createGrid(selector);
      first_run = false;
    }

  }

}
