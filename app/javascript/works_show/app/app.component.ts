import { Component, AfterViewInit } from '@angular/core';
import { WorksService } from './works.services';
import { CustomFunctions } from '../custom_functions';
import worksHTML from './templates/works.html';
import { Work } from './work';


@Component({
  selector: 'works-show',
  template: worksHTML,
  providers: [WorksService, CustomFunctions]

})
export class AppComponent implements AfterViewInit {
  works: Work[];

  constructor(
    private service: WorksService,
    private custFuncs: CustomFunctions
  ) { } 

  ngAfterViewInit() {
    this.service.getWorks().subscribe(works => this.works = works);
    var options = { srcNode: '.item', margin: '20px', width: '250px', max_width: '250px', resizable: true, transition: 'opacity 0.5s ease' }
    var node_loaded = document.querySelector('.read-grid')
    this.custFuncs.gridify(options, node_loaded);
  }

}
