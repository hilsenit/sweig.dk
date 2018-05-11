import { Component, Input, Output, EventEmitter } from '@angular/core';
import ImageNavbar from '../images/navbar.jpg';

@Component({
  selector: 'navbar',
  template: `<nav> <div class="inner-navbar" [ngStyle]="{'background-image': 'url(' + image_path + ')'}" class="nav-image">
    <div class="close-text-icon cursor-p" *ngIf="text_is_open" (click)="closeText()"></div>
  </div> </nav>`
})

export class NavbarComponent {
  @Input() text_is_open: boolean = false;
  @Output() close_text_emi = new EventEmitter(); // Doing 'emi', so you can see it in the parent template view
  image_path: string = ImageNavbar;

  closeText() {
    document.querySelector('body').style.overflow = "scroll";
    this.close_text_emi.emit(null); 
  }
}
