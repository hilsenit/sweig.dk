import { Component } from '@angular/core';

@Component({
  selector: 'works-show',
  template: `<h1>Hello {{name}}</h1>`

})
export class AppComponent {
  name: String = 'HANDSOME';
}
