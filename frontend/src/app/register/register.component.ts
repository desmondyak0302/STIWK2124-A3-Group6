import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../services/auth';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'] // Remove this line if you do not use a separate CSS file
})
export class RegisterComponent {
  
  // These field keys must match your Spring Boot backend User entity properties exactly!
  accountData = {
    username: '',
    password: ''
  };

  errorMessage: string = '';
  successMessage: string = '';

  constructor(private authService: AuthService, private router: Router) {}

  onRegister(): void {
    this.errorMessage = '';
    this.successMessage = '';

    // Simple validation before shipping to backend
    if (!this.accountData.username || !this.accountData.password) {
      this.errorMessage = 'Please fill out all required fields.';
      return;
    }

    // Call your backend API connection via the service
    this.authService.register(this.accountData).subscribe({
      next: (response) => {
        console.log('User saved successfully in arl_db:', response);
        this.successMessage = 'Account created successfully!';
        
        // Clear the input boxes
        this.accountData = { username: '', password: '' };

        // Redirect to login page after a 2-second delay
        setTimeout(() => {
          this.router.navigate(['/login']);
        }, 2000);
      },
      error: (err) => {
        console.error('Network Error while saving user:', err);
        // Display the database validation message sent from UserController
        this.errorMessage = err.error?.message || 'Failed to save account. Server might be down.';
      }
    });
  }
}