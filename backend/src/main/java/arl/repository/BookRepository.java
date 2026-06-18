package arl.repository;

import arl.entity.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
    
    /**
     * Student B Task: Search functionality.
     * This method searches for books where the title contains the keyword 'q', 
     * ignoring case, and returns a paginated result.
     */
    Page<Book> findByTitleContainingIgnoreCase(String title, Pageable pageable);
}