declare function require(path: string);
import { Component, Input, Output, EventEmitter, ViewChild, ElementRef, OnChanges } from '@angular/core';
import { trigger, state, style, animate, transition } from '@angular/animations';
import { Work } from './work';
import { User } from './user';
import NavbarHTML from './templates/navbar.html';
import NavbarBackground from '../images/navbar.jpg';
import CloseIcon from '../images/cancel.png';

@Component({
  selector: 'navbar',
  template: NavbarHTML, 
  animations: [
    trigger('loadingAnimation', [
      state('loading', style({
        backgroundPositionX: "{{loading_left_pos}}"
      }), {loading_left_pos: "100%"}),
      state('notloading',   style({
        backgroundPositionX: "{{loading_left_pos}}"
        }), {loading_left_pos: "100%"}),
      transition('notloading => loading', animate('1000ms ease-in'))
    ])
  ]
})

export class NavbarComponent implements OnChanges {
  @ViewChild('navbar_inner') navbar_inner: ElementRef;
  @Input() selected_work: Work = null;
  @Input() user_choosen: User = null;
  @Input() loading_input: string = '';
  @Input() show_search_field: boolean = false;
  @Output() close_user_emi = new EventEmitter(); // Doing 'emi', so you can see it in the parent template view
  @Output() show_search_field_emi = new EventEmitter();
  @Output() close_text_emi = new EventEmitter();
  @Output() show_users_works = new EventEmitter();
  loading_left_pos: string = '';
  state: string = 'notloading';
  navbar_image_url: string = NavbarBackground;
  close_icon: string = CloseIcon;

  ngOnChanges() {
    if (this.loading_input == 'loading') {
      let only_num = this.loading_left_pos.replace("%", "");
      let new_number = Number(only_num) + 100;
      this.loading_left_pos = new_number + '%';
      debugger;
      this.state = this.loading_input; // For animation
    }
  }

  showSearchField() {
    let show_or_hide = this.show_search_field ? false : true;
    this.show_search_field_emi.emit(show_or_hide);
  }

  closeText() {
    this.close_text_emi.emit(null); 
  }

  closeUser() {
    this.user_choosen = null;
    this.close_user_emi.emit('complete');
  }

  selectUser() {
    this.show_users_works.emit(this.selected_work);
    this.close_text_emi.emit(true); // scroll up
  }
}
