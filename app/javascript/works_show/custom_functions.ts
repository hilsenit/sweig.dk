export class CustomFunctions {
  truncateHTMLText(text: string): string {
    let with_spaces = text.replace(/<br \/>/gm, "&nbsp;");
    let without_html = with_spaces.replace(/<(?:.|\n)*?>/gm, '');
    let truncated_string = without_html.substring(0, 160) + "...";
    console.log(truncated_string);
    return truncated_string;
  }
}
