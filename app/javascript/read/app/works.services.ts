import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs';
import { Work } from './work';
import { map } from 'rxjs/operators';
const COLUMN_WIDTH: number = 250;
const MAX_WIDTH_OF_GRID: number = 1250;
const ITEM_CA_HEIGHT: number = 200;

@Injectable()

export class WorksService {
  constructor(private http: Http) {}

  extractData(res: Response) {
    return res.json();
  }

  getWorks(works_count): Observable<Work[]> {
    let url = works_count ? `/laes.json?works_count=${works_count}` : "/laes.json";
    return this.http.get(url).pipe(map(this.extractData));
  } 

  moreWorks(works_already_loadet: number) {
    console.log("Already loadet:" + works_already_loadet);  
  }

  getUsersWorks(user_id: number) {
    let url = `/get_user_works.json?user_id=${user_id}`;
    return this.http.get(url).pipe(map(this.extractData));

  }

  worksToLoad(grid_width, window_height) {
    let columns = grid_width > MAX_WIDTH_OF_GRID ? 5 : Math.ceil(grid_width / COLUMN_WIDTH);
    let rows = Math.floor(window_height / ITEM_CA_HEIGHT);
    let number_of_works = columns * rows ;
    return  number_of_works;
  }
}
