import { Component, Input } from '@angular/core';
import ImageNavbar from '../images/navbar.jpg';

@Component({
  selector: 'navbar',
  template: `<nav> <div [ngStyle]="{'background-image': 'url(' + image_path + ')'}" class="nav-image"></div> </nav>`
})

export class NavbarComponent {
  image_path: string = ImageNavbar;
}
