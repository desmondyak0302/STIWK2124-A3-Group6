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
    email: '',
    password: '',
    role: 'STUDENT' // Default value
  };

  errorMessage: string = '';
  successMessage: string = '';

  constructor(private authService: AuthService, private router: Router) {}

  onRegister(): void {
    this.errorMessage = '';
    this.successMessage = '';

    if (!this.accountData.username || !this.accountData.email || !this.accountData.password) {
      this.errorMessage = 'Please fill out all required fields.';
      return;
    }

    // Debugging: Log the data before sending to ensure the role is correct
    console.log('Sending Registration Data:', this.accountData);

    this.authService.register(this.accountData).subscribe({
      next: (response: any) => {
        this.successMessage = '✅ Account created successfully! Redirecting...';
        this.accountData = { username: '', email: '', password: '', role: 'STUDENT' };

        setTimeout(() => {
          this.router.navigate(['/login']);
        }, 2000);
      },
      error: (err: any) => {
        this.errorMessage = err.error?.message || '❌ Failed to save account.';
      }
    });
  }
}