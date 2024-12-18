import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CompteurService } from './services/compteur.service';
import { Observable } from 'rxjs';
import { AsyncPipe } from '@angular/common';

@Component({
  selector: 'app-root',
  imports: [RouterOutlet, AsyncPipe],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  title = 'App';
  _compteur!: Observable<{nombre: number}>

  constructor(private compteurService: CompteurService) { }
  
  ngOnInit(): void {
    this._compteur = this.compteurService.getCompteur();
  }

}
