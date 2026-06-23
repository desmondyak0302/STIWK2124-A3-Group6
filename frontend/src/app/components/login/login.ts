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
  successMessage = ''; 

  constructor(private authService: AuthService, private router: Router) {}

  onLogin(): void {
    this.errorMessage = '';
    this.successMessage = '';

    if (!this.username.trim() || !this.password.trim()) {
      this.errorMessage = 'Please enter both username and password.';
      return;
    }

    // Connects to your backend validation stream via AuthService
    this.authService.login(this.username, this.password).subscribe({
      next: (response: any) => {
        this.successMessage = '🔑 Login successful! Access granted.';
        
        // Brief message delay before moving the user to the catalog dashboard
        setTimeout(() => {
          this.router.navigate(['/books']);
        }, 1200);
      },
      error: (err: any) => {
        console.error('Login failed', err);
        // Extracts structural error response string messages safely from backend maps
        this.errorMessage = err.error?.message || '❌ Invalid credentials. Please check your username and password.';
      }
    });
  }

  /**
   * Helper method to jump to the registration form page instantly
   */
  goToRegister(): void {
    this.router.navigate(['/register']);
  }
}