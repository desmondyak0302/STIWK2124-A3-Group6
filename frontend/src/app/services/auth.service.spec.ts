import { TestBed } from '@angular/core/testing';
import { AuthService } from './auth';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

describe('AuthService', () => {
  let service: AuthService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [AuthService]
    });
    service = TestBed.inject(AuthService);
    httpMock = TestBed.inject(HttpTestingController);
    
    // Clear localStorage before each test to ensure a clean state
    localStorage.clear();
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should return false when no authHeader exists (isLoggedIn)', () => {
    // Using .toBe(false) instead of .toBeFalse() for Jasmine compatibility
    expect(service.isLoggedIn()).toBe(false);
  });

  it('should return true when authHeader exists in localStorage (isLoggedIn)', () => {
    localStorage.setItem('authHeader', 'Basic dGVzdDp0ZXN0');
    // Using .toBe(true) instead of .toBeTrue() for Jasmine compatibility
    expect(service.isLoggedIn()).toBe(true);
  });

  it('should clear localStorage on logout', () => {
    localStorage.setItem('authHeader', 'some-token');
    service.logout();
    expect(localStorage.getItem('authHeader')).toBeNull();
  });
});