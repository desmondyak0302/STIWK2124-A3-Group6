This project is the backend for the Accessible Reading List(ARL) as part of ** STIWK2124 Assignment1**. 

Key Features:
a)CRUD Operations: Students can add,read,updare and delete book records.
b)Search & Pagination: Retrieve books by suing keywords with page-based navigation.
c)Data Validation: Ensures all book entries meet required standards (e.g. non-empty titles).
d)Basic Authentication: Securely protects write operations(POST, PUT, DELETE).

Team Members(Group-6):
1.Tan Xuan Jie (303956)- Entity & CRUD Development
2.Nuranisya binti Ramlan (301119)- Pagination & Search Implementation
3.Tan Zhao Bin (304666)- MySQL Database &Security Configuration
4.Wong Zheng Quan (303872)- Git Management &Documentation
5.Team Leader- Desmond Yap Teik Jun (304294)- Testing & Quality Assurance

Database ERD diagram:
<img width="653" height="1030" alt="image" src="https://github.com/user-attachments/assets/a7a105ba-27a9-4b87-a7d7-11e1c0bd267e" />

Setup & Installation tools:
* Java 17 or higher
* IDE: Visual Stadio Code(with Java Extension Pack)
* MySQL 8.0
* Maven 3.x

Step:
1)Clone the repository to your Visual Stadio Code
2)Login in to MySQL Workbench and run 'CREATE DATABASE ARL_DB;'
3)Copy & Paste 'schema.sql' from github to create the tables
4)Update 'src/main/resources/application.properties' with your own MySQL username and password. And click save.
5)make sure your localhost is correct with MySQL (Usually is 3306)
6)Run 'src/main/java/com/example/demo/DemoApplication.java.

API Sample Requests:
a) Method: GET
  URL:http://localhost:8080/api/books
  
  pagination/search:
  http://localhost:8080/api/books?q=Clean&page=0&size=5

b)Method: POST
  URL:http://localhost:8080/api/books
  Body: select raw ->JSON enter:

  JSON{
  "title": "Spring Boot Tutorial",
    "author": "Wong Zheng Quan",
    "category": "Education",
    "shortDescription": "A complete guide for UUM students."
    }

  c)Method: PUT
  URL:http://localhost:8080/api/books/1
   Body: select raw ->JSON enter:

   JSON{
    "title": "Clean Code (Updated)",
    "author": "Robert C. Martin",
    "category": "Software Engineering",
    "shortDescription": "This is an updated description for our UUM project."
     }

  d)Method: DELETE
  URL: http://localhost:8080/api/books/1

Testing & Demo
* All endpoints have been verified using Postman.
* [Click here to watch the 3-minute demonstration][([video link])](https://youtu.be/-LGSbHt6HxQ).


  
>>>>>>>>> Temporary merge branch 2
