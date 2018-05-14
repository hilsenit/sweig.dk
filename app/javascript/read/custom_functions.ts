import { QueryList } from '@angular/core';
export class CustomFunctions {

  truncateHTMLText(text: string): string {
    let with_spaces = text.replace(/<br \/>/gm, "&nbsp;");
    let without_html = with_spaces.replace(/<(?:.|\n)*?>/gm, '');
    let truncated_string = without_html.substring(0, 160) + "...";
    return truncated_string;
  }
  
  sleep(ms: number) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  addAndRemoveClassToQueryList(dom_elements: QueryList<any>, event_listener: string, add_class: string, id: number, before_id_class: string) {
    dom_elements.forEach(element => {
      var dom_element = element.nativeElement;
      if (!dom_element.classList.contains(before_id_class + id)) {
        dom_element.classList.add(add_class);
        dom_element.addEventListener(event_listener, function() {
          dom_elements.forEach( new_work => {
            new_work.nativeElement.classList.remove(add_class);
          })
        });
      }
    });



  }

  returnBooleanValue(input: any) {
    return Boolean(input)
  }
}


