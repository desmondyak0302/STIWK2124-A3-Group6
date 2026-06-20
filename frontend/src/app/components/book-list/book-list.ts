import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { BookService } from '../../services/book';
import { AuthService } from '../../services/auth';

@Component({
  selector: 'app-book-list',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './book-list.html',
  styleUrls: ['./book-list.css']
})
export class BookListComponent implements OnInit {
  books: any[] = [];
  currentPage: number = 0;
  pageSize: number = 6;
  searchQuery: string = '';
  totalPages: number = 0;

  constructor(
    private bookService: BookService,
    private router: Router,
    public authService: AuthService
  ) {}

  ngOnInit(): void {
    this.loadBooks();
  }

  loadBooks(): void {
    this.bookService.getBooks(this.currentPage, this.pageSize, this.searchQuery).subscribe({
      next: (response) => {
        this.books = response.books || response.content || response;
        this.totalPages = response.totalPages || 0;
      },
      error: (err) => {
        console.error('Database connection error:', err);
        alert('Failed to load books. Please ensure your backend is running on port 8080.');
      }
    });
  }

  onSearch(): void {
    this.currentPage = 0;
    this.loadBooks();
  }

  readAloud(title: string, author: string): void {
    window.speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(`Now reading: ${title} by ${author}`);
    utterance.lang = 'en-US';
    window.speechSynthesis.speak(utterance);
  }

  onDeleteBook(id: number): void {
    if (!this.authService.isLoggedIn()) {
      alert('Please log in to delete books.');
      this.router.navigate(['/login']);
      return;
    }

    if (confirm('Permanently delete this record?')) {
      this.bookService.deleteBook(id).subscribe({
        next: () => {
          alert('Book deleted successfully!');
          this.loadBooks();
        },
        error: (err) => {
          if (err.status === 401 || err.status === 403) {
            alert('Security Error: You do not have permission to delete this.');
          } else {
            alert('Delete failed. Verify your database connection.');
          }
        }
      });
    }
  }

  onAddBookClick(): void {
    if (!this.authService.isLoggedIn()) {
      alert('Please log in to add books.');
      this.router.navigate(['/login']);
      return;
    }
    this.router.navigate(['/books/add']);
  }

  onEditBookClick(id: number): void {
    if (!this.authService.isLoggedIn()) {
      alert('Please log in to edit books.');
      this.router.navigate(['/login']);
      return;
    }
    this.router.navigate(['/books/edit', id]);
  }

  // Updated logout method to handle instant view redirection
  onLogout(): void {
    this.authService.logout();
    alert('Logged out successfully.');
    this.router.navigate(['/login']); // Redirects user directly back to staff login page
  }

  goToNextPage(): void {
    if (this.currentPage < this.totalPages - 1) {
      this.currentPage++;
      this.loadBooks();
    }
  }

  goToPreviousPage(): void {
    if (this.currentPage > 0) {
      this.currentPage--;
      this.loadBooks();
    }
  }
}