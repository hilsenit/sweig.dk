import { Component, OnInit } from '@angular/core';
import { WorksService } from './services/works.service';
import { Work } from './work';

@Component({
  selector: 'works-show',
  template: `<h1>Hello {{name}}</h1>`,
  providers: [WorksService]

})
export class AppComponent implements OnInit {
  works: Work[];

  constructor(private service: WorksService) { }

  ngOnInit() {
    this.service.getWorks().subscribe(works => this.works = works);
  }
}
