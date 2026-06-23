package arl.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "book")
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bookID")
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "short_description", columnDefinition = "TEXT")
    private String shortDescription;

    @Column(name = "language")
    private String language;

    @Column(name = "publicationDate")
    private LocalDate publicationDate;

    @Column(name = "authorID")
    private Integer authorId;

    @Column(name = "vendorID")
    private Integer vendorId;

    @Column(name = "categoryID")
    private Integer categoryId;

    // --- Constructors ---
    public Book() {
    }

    public Book(Integer id, String title, String shortDescription, String language, LocalDate publicationDate,
            Integer authorId, Integer vendorId, Integer categoryId) {
        this.id = id;
        this.title = title;
        this.shortDescription = shortDescription;
        this.language = language;
        this.publicationDate = publicationDate;
        this.authorId = authorId;
        this.vendorId = vendorId;
        this.categoryId = categoryId;
    }

    // --- Getters and Setters ---
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public LocalDate getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(LocalDate publicationDate) {
        this.publicationDate = publicationDate;
    }

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    public Integer getVendorId() {
        return vendorId;
    }

    public void setVendorId(Integer vendorId) {
        this.vendorId = vendorId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }
}