package arl.controller;

import arl.entity.Book;
import arl.service.BookService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Optional;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@SpringBootTest
@AutoConfigureMockMvc
public class BookControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private BookService bookService;

    @Autowired
    private ObjectMapper objectMapper;

 
    @Test
    @WithMockUser(authorities = {"ADMIN"}) 
    public void testCreateBook_Success() throws Exception {
        Book sampleBook = new Book();
        sampleBook.setTitle("Software Engineering");
        
        Book savedBook = new Book();
        savedBook.setBookID(1);
        savedBook.setTitle("Software Engineering");

        Mockito.when(bookService.createBook(Mockito.any(Book.class))).thenReturn(savedBook);

        mockMvc.perform(post("/api/books")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(sampleBook)))
                .andExpect(status().isCreated()) 
                .andExpect(jsonPath("$.title").value("Software Engineering"));
    }

  
    @Test
    public void testGetBookById_NotFound_Returns404() throws Exception {
        int nonExistentId = 999;
        Mockito.when(bookService.getBookById(nonExistentId)).thenReturn(Optional.empty());

        mockMvc.perform(get("/api/books/" + nonExistentId)) 
                .andExpect(status().isNotFound()); 
    }

    @Test
    public void testCreateBook_Anonymous_Returns401() throws Exception {
        Book sampleBook = new Book();
        sampleBook.setTitle("Unsecured Book");

        mockMvc.perform(post("/api/books") 
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(sampleBook)))
                .andExpect(status().isUnauthorized()); 
    }
}