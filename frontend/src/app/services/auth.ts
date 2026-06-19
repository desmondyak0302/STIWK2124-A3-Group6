import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, tap } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  // Your Spring Boot backend base URL
  private apiUrl = 'http://localhost:8080/api/auth'; 

  private currentUsername: string | null = null;
  private isUserAuthenticated = false;

  constructor(private http: HttpClient) {}

  // 1. REGISTER: Sends account data to the backend database
  register(user: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, user);
  }

  // 2. LOGIN: Fixed to accept two string arguments from login.ts
  login(username: string, password: string): Observable<any> {
    const credentials = { username: username, password: password };
    return this.http.post(`${this.apiUrl}/login`, credentials).pipe(
      tap((response: any) => {
        // If login is successful, save the state locally in the app
        if (response && response.status === 'success') {
          this.currentUsername = username;
          this.isUserAuthenticated = true;
        }
      })
    );
  }

  // 3. LOGOUT: Clears local session
  logout(): void {
    this.currentUsername = null;
    this.isUserAuthenticated = false;
  }

  isLoggedIn(): boolean {
    return this.isUserAuthenticated;
  }

  // Restored to fix the compilation crash in login.ts
  getCredentials(): string | null {
    if (!this.currentUsername) {
      return null;
    }
    return btoa(`${this.currentUsername}:`);
  }

  getUsername(): string | null {
    return this.currentUsername;
  }
}