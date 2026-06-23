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

    public Page<Book> getAllBooks(Pageable pageable) {
        return bookRepository.findAll(pageable);
    }

    public Optional<Book> getBookById(Integer id) {
        return bookRepository.findById(id);
    }

    // --- CREATE METHODS ---
    public Book saveBook(Book book) {
        return bookRepository.save(book);
    }

    /**
     * FIXES: "cannot find symbol method createBook(arl.entity.Book)"
     * Maps to your BookController call smoothly.
     */
    public Book createBook(Book book) {
        return bookRepository.save(book);
    }

    public void deleteBook(Integer id) {
        bookRepository.deleteById(id);
    }

    public Book updateBook(Integer id, Book bookDetails) {
        return bookRepository.findById(id).map(book -> {
            if (bookDetails.getTitle() != null) {
                book.setTitle(bookDetails.getTitle());
            }
            if (bookDetails.getShortDescription() != null) {
                book.setShortDescription(bookDetails.getShortDescription());
            }
            // --- UPDATED: Replaced old ID/Date checks with the new flat fields ---
            if (bookDetails.getAuthor() != null) {
                book.setAuthor(bookDetails.getAuthor());
            }
            if (bookDetails.getCategory() != null) {
                book.setCategory(bookDetails.getCategory());
            }
            
            return bookRepository.save(book);
        }).orElseThrow(() -> new RuntimeException("Book record not found with id " + id));
    }

    // --- SEARCH METHODS ---
    public Page<Book> searchBooks(String title, Pageable pageable) {
        return bookRepository.findByTitleContainingIgnoreCase(title, pageable);
    }

    /**
     * FIXES: "cannot find symbol method
     * searchBooksByTitle(java.lang.String,org.springframework.data.domain.Pageable)"
     * Maps to your BookController search call smoothly.
     */
    public Page<Book> searchBooksByTitle(String title, Pageable pageable) {
        return bookRepository.findByTitleContainingIgnoreCase(title, pageable);
    }
}