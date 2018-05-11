import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';
import { ReadComponent } from './read.component';
import { NavbarComponent } from './navbar.component';

@NgModule({
  declarations: [
    ReadComponent, NavbarComponent
  ],
  imports: [
    HttpModule,
    BrowserModule
  ],
  providers: [],
  bootstrap: [ReadComponent]
})
export class AppModule { }
