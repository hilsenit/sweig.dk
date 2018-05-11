import { Component, OnInit, AfterViewChecked } from '@angular/core';
import { WorksService } from './works.services';
import { CustomFunctions } from '../custom_functions';
import { Gridify } from '../gridify';
import readHTML from './templates/read.html';
import { Work } from './work';
import { User } from './user';


@Component({
  selector: 'read',
  template: readHTML,
  providers: [WorksService, CustomFunctions, Gridify]
})

export class ReadComponent implements OnInit {
  works: Work[];
  selected_work: Work = null;
  user_choosen: User = null;
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
    if (this.numOfTimes == 4) { // Rendered 10 times if i don't do this
      this.setGrid();
    }
    this.numOfTimes += 1;
  }

  setGrid() {
    var selector = document.querySelector('.read-grid');
    this.gridify.createGrid(selector);
  }

  showText(work) {
    document.querySelector('body').style.overflow = "hidden";
    this.selected_work = work;
  }

  notUsersWork(user_id, remove = false, username = '') { 
    var added_class = remove ? 'display-n' : 'high-opacity' 
    var not_users_works = document.querySelectorAll(`.item:not(.user-id-${String(user_id)})`);
    Array.from(not_users_works).forEach(function(work) {
      work.classList.add(added_class);
    });
    if (remove) {
      this.setGrid();
      this.user_choosen = {name: username, id: user_id};
    }
  }

  showAllWorks(event) {
    var works = document.querySelectorAll('.item');
    Array.from(works).forEach(function(work) {
      work.classList.remove('display-n', 'high-opacity');
    });
    this.setGrid();
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
