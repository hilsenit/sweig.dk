declare function require(path: string);
import { Component, Input, Output, EventEmitter, ViewChild, ElementRef, OnChanges } from '@angular/core';
import { Work } from './work';
import { User } from './user';
import NavbarHTML from './templates/navbar.html';
import NavbarBackground from '../images/navbar.jpg';
import CloseIcon from '../images/cancel.png';

@Component({
  selector: 'navbar',
  template: NavbarHTML, 
})

export class NavbarComponent implements OnChanges {
  @ViewChild('navbar_inner') navbar_inner: ElementRef;
  @Input() selected_work: Work = null;
  @Input() user_choosen: User = null;
  @Input() loading: boolean = false;
  @Input() show_search_field: boolean = false;
  @Input() search_str: string = '';
  @Input() search_empty: boolean = false;
  @Output() close_user_emi = new EventEmitter(); // Doing 'emi', so you can see it in the parent template view
  @Output() show_search_field_emi = new EventEmitter();
  @Output() close_text_emi = new EventEmitter();
  @Output() show_users_works = new EventEmitter();
  navbar_image_url: string = NavbarBackground;
  close_icon: string = CloseIcon;

  ngOnChanges() {
    var inner_navbar = this.navbar_inner.nativeElement;
    if(this.loading && !inner_navbar.classList.contains('nav-image-move')) {
      inner_navbar.classList.add('nav-image-move');
    } else if (!this.loading) {
      let position = window.getComputedStyle(inner_navbar).backgroundPositionX;
      inner_navbar.style.backgroundPositionX = position;
      inner_navbar.classList.remove('nav-image-move');
    }
  }

  showSearchField() {
    let show_or_hide = this.show_search_field ? false : true;
    this.show_search_field_emi.emit(show_or_hide);
  }

  getContentIfSearchEmpty() {
    if(this.show_search_field && !this.loading) {
      if(!this.search_empty && this.search_str != '') {
        var content = `${this.search_str}:`;
      } 
      if (this.search_empty){
        var content = `Intet at finde under '${this.search_str}'`;
      }
      return content;
    }
    return false;
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
