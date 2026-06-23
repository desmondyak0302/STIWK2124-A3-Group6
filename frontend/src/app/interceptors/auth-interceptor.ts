import { HttpInterceptorFn, HttpErrorResponse } from '@angular/common/http';
import { catchError, throwError } from 'rxjs';
import { inject } from '@angular/core';
import { AuthService } from '../services/auth';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthService);
  const method = req.method;

  // ONLY enforce token injection on mutating database modification requests
  if (method === 'POST' || method === 'PUT' || method === 'DELETE') {
    const token = authService.getAuthHeader();

    if (token) {
      // Clone the request stream and attach the authorization metadata cleanly
      const secureReq = req.clone({
        setHeaders: {
          Authorization: token
        }
      });

      return next(secureReq).pipe(
        catchError((error: HttpErrorResponse) => {
          if (error.status === 401) {
            alert('🔒 Unauthorized! Session invalid or credentials missing.');
          } else if (error.status === 0 || error.status >= 500) {
            alert('⚠️ Connection Timeout or Backend Server Down! Please try again later.');
          }
          return throwError(() => error);
        })
      );
    }
  }

  // GET requests or unauthenticated routes slide directly through un-altered
  return next(req).pipe(
    catchError((error: HttpErrorResponse) => {
      if (error.status === 0 || error.status >= 500) {
        alert('⚠️ Connection Timeout or Backend Server Down! Please try again later.');
      }
      return throwError(() => error);
    })
  );
};