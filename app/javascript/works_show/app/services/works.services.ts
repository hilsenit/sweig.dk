import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Observable } from 'rxjs';
import { Work } from '../work';

@Injectable()

export class WorksService {
  constructor(private http: Http) {}

  extractData(res: Response) {
    return res.json();
  }

  getWorks(): Observable<Work[]> {
    return this.http.get("/laes.json").map(this.extractData);
  } 
}
