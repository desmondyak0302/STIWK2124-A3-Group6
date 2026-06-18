import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private username: string | null = null;
  private password: string | null = null;

  login(username: string, password: string): void {
    this.username = username;
    this.password = password;
  }

  logout(): void {
    this.username = null;
    this.password = null;
  }

  isLoggedIn(): boolean {
    return this.username !== null && this.password !== null;
  }

  getCredentials(): string | null {
    if (!this.username || !this.password) {
      return null;
    }
    return btoa(`${this.username}:${this.password}`);
  }

  getUsername(): string | null {
    return this.username;
  }
}