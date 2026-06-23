package arl.controller;

import arl.entity.Book;
import arl.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/books")
@CrossOrigin(origins = {"http://localhost:4200", "http://localhost"})
public class BookController {

    @Autowired
    private BookService bookService;

    /**
     * Handles pagination and search text keywords seamlessly.
     * Accessible via: GET http://localhost:8080/api/books?page=0&size=6
     */
    @GetMapping
    public ResponseEntity<Page<Book>> getAllBooks(
            @RequestParam(required = false) String q,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);

        // If the user provided a search term, call the custom query method
        if (q != null && !q.trim().isEmpty()) {
            return ResponseEntity.ok(bookService.searchBooksByTitle(q, pageable));
        }

        // Otherwise, return a paginated list of all books
        return ResponseEntity.ok(bookService.getAllBooks(pageable));
    }

    /**
     * Fetches a single book details matching primitive identifiers.
     */
    @GetMapping("/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Integer id) {
        Optional<Book> book = bookService.getBookById(id);
        return book.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    /**
     * Administrative entry persistence mapping.
     * Accessible via: POST http://localhost:8080/api/books
     */
    @PostMapping
    public ResponseEntity<Book> createBook(@RequestBody Book book) {
        Book savedBook = bookService.createBook(book);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedBook);
    }

    /**
     * Relational attribute modifications processing transaction pipeline.
     */
    @PutMapping("/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Integer id, @RequestBody Book bookDetails) {
        try {
            Book updatedBook = bookService.updateBook(id, bookDetails);
            return ResponseEntity.ok(updatedBook);
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    /**
     * Erases targets safely from active database memory contexts.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Integer id) {
        try {
            bookService.deleteBook(id);
            return ResponseEntity.noContent().build();
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }
}