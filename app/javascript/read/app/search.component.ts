import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'search',
  template: `<input #input (keyup)="searchString(input.value)" type="text" class="search-field text-center">`
})

export class SearchComponent {
  @Output() search_string_emi = new EventEmitter();

  searchString(search_by: string) {
    if (search_by.length < 2) { return }
    this.search_string_emi.emit(search_by);
  }

}
