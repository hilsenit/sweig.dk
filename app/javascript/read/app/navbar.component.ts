declare function require(path: string);
import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Work } from './work';
import { User } from './user';
import NavbarHTML from './templates/navbar.html';
import NavbarBackground from '../images/navbar.jpg';
import CloseIcon from '../images/cancel.png';

@Component({
  selector: 'navbar',
  template: NavbarHTML
})

export class NavbarComponent {
  @Input() selected_work: Work = null;
  @Input() user_choosen: User = null;
  @Output() close_user_emi = new EventEmitter();; // Doing 'emi', so you can see it in the parent template view
  @Output() close_text_emi = new EventEmitter();
  @Output() show_users_works = new EventEmitter();
  navbar_image_url: string = NavbarBackground;
  close_icon: string = CloseIcon;

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
