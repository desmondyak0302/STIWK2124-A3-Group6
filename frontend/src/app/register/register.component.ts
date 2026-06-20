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
  styleUrls: ['./register.component.css']
})
export class RegisterComponent {
  
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

    if (!this.accountData.username || !this.accountData.password) {
      this.errorMessage = 'Please fill out all required fields.';
      return;
    }

    this.authService.register(this.accountData).subscribe({
      next: (response: any) => {
        console.log('User saved successfully in arl_db:', response);
        this.successMessage = '✅ Account created successfully! Redirecting to login...';
        
        this.accountData = { username: '', password: '' };

        // Redirect to login page after a 2-second delay
        setTimeout(() => {
          this.router.navigate(['/login']);
        }, 2000);
      },
      error: (err: any) => {
        console.error('Network Error while saving user:', err);
        this.errorMessage = err.error?.message || '❌ Failed to save account. Server might be down.';
      }
    });
  }
}