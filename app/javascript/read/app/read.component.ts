import { Component, OnInit, AfterViewChecked } from '@angular/core';
import { WorksService } from './works.services';
import { CustomFunctions } from '../custom_functions';
import { Gridify } from '../gridify';
import readHTML from './templates/read.html';
import { Work } from './work';


@Component({
  selector: 'read',
  template: readHTML,
  providers: [WorksService, CustomFunctions, Gridify]
})

export class ReadComponent implements OnInit {
  works: Work[];
  numOfTimes: number = 1;

  constructor(
    private service: WorksService,
    private custFuncs: CustomFunctions,
    private gridify: Gridify
  ) { } 

  ngOnInit() {
    this.service.getWorks().subscribe(works => this.works = works);
  }

  ngAfterViewChecked() { // It's run multiple times - i don't know how to fix it yet
    var selector = document.querySelector('.read-grid');
    if (selector != null && this.numOfTimes == 4) { // Rendered 10 times if i don't do this
      this.gridify.createGrid(selector);
      console.log(this.numOfTimes);
    }
    this.numOfTimes += 1;
  }

  highlightWorks(user_id) {
    var not_users_works = document.querySelectorAll(`.item:not(.user-id-${String(user_id)})`);
    Array.from(not_users_works).forEach(function(work) {
      work.classList.add('high-opacity');
    });
  }

  checkHighlight(work_id) {
    var this_work = document.querySelector(`.work-id-${work_id}`); 
    if (this_work.classList.contains('high-opacity')) {
      let works = document.querySelectorAll('.item');
      Array.from(works).forEach(function(work) {
        work.classList.remove('high-opacity');
      });
    } else {
      return;
    }
  }

}
