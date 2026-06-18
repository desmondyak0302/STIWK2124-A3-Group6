import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { inject } from '@angular/core';
import { AuthService } from '../services/auth';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthService);
  const method = req.method;

  if (method === 'POST' || method === 'PUT' || method === 'DELETE') {
    const credentials = authService.getCredentials();

    if (credentials) {
      const secureReq = req.clone({
        setHeaders: {
          Authorization: `Basic ${credentials}`
        }
      });

      return next(secureReq).pipe(
        catchError((error: HttpErrorResponse) => {
          if (error.status === 0 || error.status >= 500) {
            alert('⚠️ Connection Timeout or Backend Server Down! Please try again later.');
          }
          return throwError(() => error);
        })
      );
    }
  }

  return next(req).pipe(
    catchError((error: HttpErrorResponse) => {
      if (error.status === 0 || error.status >= 500) {
        alert('⚠️ Connection Timeout or Backend Server Down! Please try again later.');
      }
      return throwError(() => error);
    })
  );
};