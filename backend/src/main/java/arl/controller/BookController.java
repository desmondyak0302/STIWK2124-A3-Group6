package arl.controller;

import arl.entity.Book;
import arl.service.BookService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/books")
@CrossOrigin(origins = "*") // Allows the frontend to connect without CORS errors[cite: 1]
public class BookController {

    @Autowired
    private BookService bookService;

    // Creates a new book; @Valid ensures inputs meet the requirements in Book.java[cite: 1]
    @PostMapping
    public ResponseEntity<Book> createBook(@Valid @RequestBody Book book) {
        Book savedBook = bookService.createBook(book);
        return new ResponseEntity<>(savedBook, HttpStatus.CREATED);
    }

    /**
     * STUDENT B TASK: ADVANCED ENDPOINT
     * This handles three things: 
     * 1. Filtering by keyword (q)
     * 2. Page numbering (page)
     * 3. Items per page (size)
     * Example: /api/books?q=Harry&page=0&size=5[cite: 1]
     */
    @GetMapping
    public ResponseEntity<Page<Book>> getAllBooks(
            @RequestParam(required = false) String q, // Optional search keyword
            @RequestParam(defaultValue = "0") int page, // Default to first page
            @RequestParam(defaultValue = "10") int size // Default to 10 books
    ) {
        Pageable pageable = PageRequest.of(page, size);
        
        // If the user provided a search term, use the search logic[cite: 1]
        if (q != null && !q.isEmpty()) {
            return ResponseEntity.ok(bookService.searchBooks(q, pageable));
        }
        // Otherwise, just return a paginated list of all books[cite: 1]
        return ResponseEntity.ok(bookService.getAllBooks(pageable));
    }

    // Fetches a single book details
    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Long id) {
        return bookService.getBookById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Updates existing book info; validates input first[cite: 1]
    @PutMapping("/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Long id, @Valid @RequestBody Book bookDetails) {
        try {
            Book updatedBook = bookService.updateBook(id, bookDetails);
            return ResponseEntity.ok(updatedBook);
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Removes a book from the database
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        try {
            bookService.deleteBook(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }
}