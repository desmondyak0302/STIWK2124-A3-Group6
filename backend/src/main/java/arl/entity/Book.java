package arl.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "book")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer bookID;

    private String title;

    // Maps to the "short_description" column in the DB, but outputs as "shortDescription" in JSON
    @Column(name = "short_description")
    private String shortDescription;

    private String author;

    private String category;

    // --- Default Constructor ---
    public Book() {
    }

    // --- Constructor with fields ---
    public Book(String title, String shortDescription, String author, String category) {
        this.title = title;
        this.shortDescription = shortDescription;
        this.author = author;
        this.category = category;
    }

    // --- Getters and Setters ---

    public Integer getBookID() {
        return bookID;
    }

    public void setBookID(Integer bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}