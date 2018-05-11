import { Component, Input, OnChanges } from '@angular/core';
import { Text } from './text';

@Component({
  selector: 'text',
  template: `<div class="modal-view" *ngIf="text != ''">
    <div [innerHTML]="text"></div>
  </div>`
})

export class TextComponent implements OnChanges {
  @Input() text_id: number;

  ngOnChanges() {
    console.log(this.text_id);
  }
  
}
