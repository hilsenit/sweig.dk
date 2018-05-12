declare function require(path: string);
import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Work } from './work';
import { User } from './user';
import NavbarBackground from '../images/navbar.jpg';
import CloseIcon from '../images/cancel.png';


@Component({
  selector: 'navbar',
  template: `
  <nav> 
  <div [ngStyle]="{'background-image': 'url(' + navbar_image_url + ')'}" class="nav-image">
    <!-- work show -->
    <div *ngIf="selected_work" class="cursor-p" (click)="closeText()">
      <img class="close-icon" [src]="close_icon"/>
    </div>
    <div *ngIf="selected_work" (click)="selectUser()" class="text-center username cursor-p">{{selected_work.username}}</div>
    <div *ngIf="selected_work" class="hidden-ballademager"></div>
    <!-- user selected -->
    <div *ngIf="user_choosen && !selected_work" class="close-user cursor-p" (click)="closeUser()">
      <img class="close-icon" [src]="close_icon"/>
    </div>
    <div *ngIf="user_choosen && !selected_work" class="text-center username">{{user_choosen.name}}</div>
    <div *ngIf="user_choosen && !selected_work" class="hidden-ballademager"></div>
  </div> </nav>`
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
