import { Routes } from '@angular/router';
import { BookListComponent } from './components/book-list/book-list';
import { BookForm } from './components/book-form/book-form';
import { LoginComponent } from './components/login/login';
import { RegisterComponent } from './register/register.component'; // Added import for register component

export const routes: Routes = [
  // 1. Force the empty root URL to redirect immediately to the registration flow
  { path: '', redirectTo: 'register', pathMatch: 'full' },
  
  // 2. Added path for registration
  { path: 'register', component: RegisterComponent },
  
  // 3. Existing operational routes
  { path: 'books', component: BookListComponent },
  { path: 'books/add', component: BookForm },
  { path: 'books/edit/:id', component: BookForm },
  { path: 'login', component: LoginComponent },
  
  // 4. Fallback wildcard rule: If a path is typed wrong, redirect back to register
  { path: '**', redirectTo: 'register' }
];