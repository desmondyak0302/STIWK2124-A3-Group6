package arl.service;

import arl.entity.Book;
import arl.repository.BookRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class BookService {

    @Autowired
    private BookRepository bookRepository;

    /**
     * STUDENT B TASK: PAGINATION LOGIC
     * Fetches a specific "slice" of books from the database.
     * Prevents the app from crashing if there are thousands of books.
     */
    public Page<Book> getAllBooks(Pageable pageable) {
        return bookRepository.findAll(pageable);
    }

    /**
     * STUDENT B TASK: SEARCH LOGIC
     * Uses the custom repository method to find books by keyword (q).
     * This is a requirement for Phase 4 of our assignment.
     */
    public Page<Book> searchBooks(String q, Pageable pageable) {
        return bookRepository.findByTitleContainingIgnoreCase(q, pageable);
    }

    // Standard CRUD - Create
    public Book createBook(Book book) {
        return bookRepository.save(book);
    }

    // Standard CRUD - Read by ID
    public Optional<Book> getBookById(Long id) {
        return bookRepository.findById(id);
    }

    // Standard CRUD - Update with error handling
    public Book updateBook(Long id, Book bookDetails) {
        return bookRepository.findById(id).map(book -> {
            book.setTitle(bookDetails.getTitle());
            book.setAuthor(bookDetails.getAuthor());
            book.setCategory(bookDetails.getCategory());
            book.setShortDescription(bookDetails.getShortDescription());
            return bookRepository.save(book);
        }).orElseThrow(() -> new RuntimeException("Book not found"));
    }

    // Standard CRUD - Delete
    public void deleteBook(Long id) {
        bookRepository.deleteById(id);
    }
}