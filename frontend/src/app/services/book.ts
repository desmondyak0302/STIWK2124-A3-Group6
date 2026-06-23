import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { AuthService } from './auth';

@Injectable({
  providedIn: 'root'
})
export class BookService {
  private apiUrl = 'http://localhost:8080/api/books';

  constructor(
    private http: HttpClient,
    private authService: AuthService
  ) {}

  /**
   * Helper function to build headers by reading directly from storage state
   */
  private getHeaders(): HttpHeaders {
    let headers = new HttpHeaders();
    // Safely requests the exact token string key from auth.ts
    const token = this.authService.getAuthHeader(); 
    if (token) {
      headers = headers.set('Authorization', token);
    }
    return headers;
  }

  /**
   * GET is open to anyone - no extra headers requested
   */
  getBooks(page: number, size: number, searchQuery?: string): Observable<any> {
    let params = new HttpParams()
      .set('page', page.toString())
      .set('size', size.toString());
    
    if (searchQuery && searchQuery.trim() !== '') {
      params = params.set('q', searchQuery);
    }
    
    return this.http.get<any>(this.apiUrl, { params });
  }

  getBookById(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }

  /**
   * POST (Protected) - Attaches Authorization header securely
   */
  addBook(bookData: any): Observable<any> {
    return this.http.post<any>(this.apiUrl, bookData, { headers: this.getHeaders() });
  }

  /**
   * PUT (Protected) - Attaches Authorization header securely
   */
  updateBook(id: number, bookData: any): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/${id}`, bookData, { headers: this.getHeaders() });
  }

  /**
   * DELETE (Protected) - Attaches Authorization header securely
   */
  deleteBook(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/${id}`, { headers: this.getHeaders() });
  }
}