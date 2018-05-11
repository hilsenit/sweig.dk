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
  @Output() close_text = new EventEmitter();
  image_path: string = ImageNavbar;

  closeText() {
    this.close_text.emit(null);
    console.log("close text");
  }
}
