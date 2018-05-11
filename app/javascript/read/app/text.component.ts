import { Component, Input, OnChanges } from '@angular/core';
import { WorksService } from './works.services';
import { Work } from './work';

@Component({
  selector: 'text',
  template: `<div class="modal-text-view" *ngIf="text_id">
      <div class="text-wrapper">
        <h2 class="text-title text-center">{{work.title}}</h2>
        <div class="text-body" [innerHTML]="work.body"></div>
      </div>
  </div>`
})

export class TextComponent implements OnChanges {
  @Input() text_id: number = null;
  work: Work;

  constructor(private service: WorksService){}
  ngOnChanges() {
    // this.service.getOneWork(this.text_id).subscribe(work => this.work = work)
  }
  
}
