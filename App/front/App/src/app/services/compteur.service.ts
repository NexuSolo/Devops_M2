import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class CompteurService {
  adresse: string = `${environment.apiUrl}/counter`;

  constructor(private http: HttpClient) { }

  getCompteur(): Observable<{nombre: number}> {
    console.log(this.adresse);
    return this.http.get<{nombre: number}>(this.adresse);
  }
}