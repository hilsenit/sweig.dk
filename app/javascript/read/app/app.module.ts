import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';
import { ReadComponent } from './read.component';
import { NavbarComponent } from './navbar.component';
import { TextComponent } from './text.component';

@NgModule({
  declarations: [
    ReadComponent, NavbarComponent, TextComponent
  ],
  imports: [
    HttpModule,
    BrowserModule
  ],
  providers: [],
  bootstrap: [ReadComponent]
})
export class AppModule { }
