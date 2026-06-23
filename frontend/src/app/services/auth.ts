import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'http://localhost:8080/api/auth'; 

  constructor(private http: HttpClient) {}

  /**
   * 1. REGISTER: Sends account data including the selected role to the backend
   */
  register(user: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, user);
  }

  /**
   * 2. LOGIN: Authenticates user and saves the role to localStorage for permission checks
   */
  login(username: string, password: string): Observable<any> {
    const credentials = { username: username, password: password };
    return this.http.post(`${this.apiUrl}/login`, credentials).pipe(
      tap((response: any) => {
        if (response) {
          // Generate standard Base64 Basic Auth token
          const authValue = 'Basic ' + btoa(`${username}:${password}`);
          
          // Save credentials and role to localStorage
          localStorage.setItem('currentUsername', username);
          localStorage.setItem('authHeader', authValue);
          
          // Capture the role from your backend response
          if (response.role) {
            localStorage.setItem('userRole', response.role);
          }
          
          console.log('✅ Login successful. Role stored:', response.role);
        }
      })
    );
  }

  /**
   * 3. LOGOUT: Wipes all user session data
   */
  logout(): void {
    localStorage.clear();
  }

  /**
   * Returns the user's role (used to show/hide Admin buttons)
   */
  getUserRole(): string | null {
    if (typeof window !== 'undefined' && window.localStorage) {
      return localStorage.getItem('userRole');
    }
    return null;
  }

  /**
   * Check if user is logged in
   */
  isLoggedIn(): boolean {
    return this.getAuthHeader() !== null;
  }

  getAuthHeader(): string | null {
    if (typeof window !== 'undefined' && window.localStorage) {
      return localStorage.getItem('authHeader');
    }
    return null;
  }

  getUsername(): string | null {
    return localStorage.getItem('currentUsername');
  }
}