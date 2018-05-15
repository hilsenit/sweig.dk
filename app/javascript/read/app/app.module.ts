import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';
import { ReadComponent } from './read.component';
import { NavbarComponent } from './navbar.component';
import { TextComponent } from './text.component';
import { SearchComponent } from './search.component';

@NgModule({
  declarations: [
    ReadComponent, NavbarComponent, TextComponent, SearchComponent
  ],
  imports: [
    HttpModule,
    BrowserModule,
    BrowserAnimationsModule // For navbar loading
  ],
  providers: [],
  bootstrap: [ReadComponent]
})
export class AppModule { }
