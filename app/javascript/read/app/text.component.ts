import { Component, Input } from '@angular/core';
import { Work } from './work';

@Component({
  selector: 'text',
  template: `<div class="modal-text-view" *ngIf="work" [ngStyle]="{'top': top_position + 'px' }">
      <div class="text-wrapper">
        <h2 class="text-title text-center">{{work.title}}</h2>
        <div class="text-body" [innerHTML]="work.body"></div>
      </div>
  </div>`
})

export class TextComponent {
  @Input() work: Work = null;
  @Input() top_position: number = 0;
}
