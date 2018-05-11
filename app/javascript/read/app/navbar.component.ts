import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Work } from './work';
import { User } from './user';
import ImageNavbar from '../images/navbar.jpg';

@Component({
  selector: 'navbar',
  template: `
  <nav> 
  <div [ngStyle]="{'background-image': 'url(' + image_path + ')'}" class="nav-image">
    <div *ngIf="selected_work || (user_choosen && !selected_work)" class="close-text-icon cursor-p" (click)="closeTextOrUser()"></div>
    <div *ngIf="selected_work" class="username">{{selected_work.username}}</div>
    <div *ngIf="user_choosen && !selected_work" class="close-text-icon cursor-p" (click)="closeTextOrUser()"></div>
    <div *ngIf="user_choosen && !selected_work" class="text-center username">{{user_choosen.name}}</div>
  </div> </nav>`
})

export class NavbarComponent {
  @Input() selected_work: Work = null;
  @Input() user_choosen: User = null;
  @Output() close_user_emi = new EventEmitter();; // Doing 'emi', so you can see it in the parent template view
  @Output() close_text_emi = new EventEmitter();
  image_path: string = ImageNavbar;

  closeTextOrUser() {
    if (this.user_choosen) {
      this.user_choosen = null;
      this.close_user_emi.emit('complete');
    } else {
      document.querySelector('body').style.overflow = "scroll";
      this.close_text_emi.emit(null); 
    }
  }
}
