import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CompteurService {
  adresse: string = "http://localhost:3000/counter";

  constructor(private http: HttpClient) { }

  getCompteur(): Observable<{nombre: number}> {
    return this.http.get<{nombre: number}>(this.adresse);
  }

}