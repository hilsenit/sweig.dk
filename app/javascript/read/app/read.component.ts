import { Component, OnInit, AfterViewChecked, HostListener, ViewChild, ViewChildren, ElementRef, QueryList } from '@angular/core';
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
  old_works: Work[];
  selected_work: Work = null;
  loading_state: string = 'notloading';
  show_search_field_emi: boolean = false;
  user_choosen: User = null;
  grid_runned: boolean = false;
  count_works_loadet: number;
  numOfTimes: number = 1;
  load_new_works: boolean = true;
  remove_works: boolean = false;
  @ViewChild("read_grid") read_grid: ElementRef;
  @ViewChildren("work_item") DOM_works: QueryList<any>;

  constructor(
    private service: WorksService,
    private custFuncs: CustomFunctions,
    private gridify: Gridify
  ) { } 

  @HostListener("window:scroll", []) onWindowScroll() {
    const verticalOffset = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
    const window_height = window.outerHeight;
    var grid_height = this.read_grid.nativeElement.clientHeight;

    // Shouldn't load new works when a user is choosen or a work is shown
    let user_or_work_opened = (this.selected_work && this.user_choosen)
    if ((verticalOffset + window_height) > grid_height && this.load_new_works && !user_or_work_opened) { 
      console.log("TRYING TO LOAD NEW WORKS");
      this.load_new_works = false;
      this.service.moreWorks(this.works.length).subscribe(
        new_works => {
          new_works.forEach(w => { 
            this.works.push(w);
            this.count_works_loadet += 1;
          })
          this.load_new_works = true;
          }
      );
    }
  }

  ngOnInit() {
    // How many works should be loaded? Based on the size of the window
  }

  ngAfterViewChecked() {
    if (!this.grid_runned) { 
      this.count_works_loadet = this.service.worksToLoad(this.read_grid.nativeElement.clientWidth, window.outerHeight)
      this.service.getWorks(this.count_works_loadet).subscribe(works => this.works = works);
      this.setGrid(); 
    } //Or else it would be runned multiple times
  }

  showSearchResult(search_string: string) {
    if (search_string != "") {
    this.loading_state = 'loading'; 
    this.old_works = this.works;
    this.service.getSearchResult(search_string).subscribe(works => {
      this.works = works;
      this.loading_state = 'notloading';
      }
    )
    } else { // If search string is empty
      this.works = this.old_works;
    }
  }

  showText(work) {
    document.querySelector('body').style.overflow = "hidden";
    this.selected_work = work;
  }

  closeText(scroll_up = false) {
    var body = document.querySelector('body');
    body.style.overflow = "auto";
    if (scroll_up )  { window.scrollTo(0, 0); }
    this.selected_work = null;
  }

  userWorks(user_id, username) {
    if (this.user_choosen) { return }
    this.remove_works = true;
    this.old_works = this.works; // Save for showAllWorks
    this.user_choosen = {name: username, id: user_id};
    this.service.getUsersWorks(user_id).subscribe(
      works => {
        this.works = works;
        this.remove_works = false;
      },
      error => console.log(error),
      () => { this.setGrid(); }
    )
  }

  fadeOutNotUsersWorks(user_id) {
    this.custFuncs.addAndRemoveClassToQueryList(this.DOM_works, 'mouseenter', 'high-opacity', user_id, 'user-id-')
  }

  setGrid() {
    this.DOM_works.changes.subscribe( () => { 
      this.gridify.createGrid(this.read_grid.nativeElement);
    })
    this.grid_runned = true; 
  }

  showAllWorks(event) { // After userWorks
    this.works = this.old_works;
    this.DOM_works.changes.subscribe(
      () => { this.setGrid() }
    )
    this.user_choosen = null;
  }
}
