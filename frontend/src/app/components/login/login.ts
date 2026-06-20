import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { AuthService } from '../../services/auth';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './login.html',
  styleUrls: ['./login.css']
})
export class LoginComponent {
  username = '';
  password = '';
  errorMessage = '';
  successMessage = ''; // Added tracking variable for notifications

  constructor(private authService: AuthService, private router: Router) {}

  onLogin(): void {
    this.errorMessage = '';
    this.successMessage = '';

    if (!this.username.trim() || !this.password.trim()) {
      this.errorMessage = 'Please enter both username and password.';
      return;
    }

    // Subscribing to your backend request stream to catch responses cleanly
    this.authService.login(this.username, this.password).subscribe({
      next: (response: any) => {
        this.successMessage = '🔑 Login successful! Access granted.';
        
        // Let the user see the alert briefly, then push them to dashboard
        setTimeout(() => {
          this.router.navigate(['/books']);
        }, 1500);
      },
      error: (err: any) => {
        console.error('Login failed', err);
        this.errorMessage = '❌ Invalid credentials. Please check your username and password.';
      }
    });
  }
}