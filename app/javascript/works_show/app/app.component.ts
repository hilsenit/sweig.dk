import { Component, OnInit, AfterViewChecked } from '@angular/core';
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

  ngAfterViewChecked() {
    
    var first_run = true;
    if (first_run) {
      let options = 
        { srcNode: '.item', margin: '20px', width: '250px', max_width: '250px', resizable: true, transition: 'opacity 0.5s ease' };
      let node_loaded = document.querySelector('.read-grid');
      this.custFuncs.gridify(options, node_loaded);
      first_run = false;
    }

  }

}
