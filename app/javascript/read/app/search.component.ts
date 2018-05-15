import { Component, Output, Input, EventEmitter } from '@angular/core';

@Component({
  selector: 'search',
  template: `
    <div class="search-field">
      <input #input (keydown.enter)="searchString(input.value)" (keydown.esc)="removeSearch()" type="text" class="text-center"> {{input.focus()}}
    </div>
    `
    
})

export class SearchComponent {
  @Output() search_string_emi = new EventEmitter();
  @Output() remove_search_field_emi = new EventEmitter();
  @Input() search_empty: boolean = false;
  search_string: string = '';

  searchString(search_by: string) {
    this.search_string = search_by;
    this.search_string_emi.emit(search_by);
  }

  removeSearch() {
    this.remove_search_field_emi.emit(false);
  }

}
