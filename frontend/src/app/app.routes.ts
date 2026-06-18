import { Routes } from '@angular/router';
import { BookListComponent } from './components/book-list/book-list';
import { BookForm } from './components/book-form/book-form';
import { LoginComponent } from './components/login/login';

export const routes: Routes = [
  { path: '', redirectTo: 'books', pathMatch: 'full' },
  { path: 'books', component: BookListComponent },
  { path: 'books/add', component: BookForm },
  { path: 'books/edit/:id', component: BookForm },
  { path: 'login', component: LoginComponent },
  { path: '**', redirectTo: 'books' }
];