### Home library management system

**Functional Scope**

Books and journals may be lent to friends with reservation system. The system should enable users for searching over the global collection with sorting options. Users will have their private Inboxes for easier library management.

**Database concept:**

 - **Users** - all users are individuals:
     - Username (unique)
     - Password (hash)
 - **Friends**:
     - User ID
     - Friend ID
 - **Books**:
     - Title
     - Author
     - Release date
     - Language
     - Genre
     - Type
     - ISBN
 - **Books Collection:**
     - User ID
     - Books IDs
 - **Lending system/archive**
     - Lending User
     - Borrowing user (must be a friend)
     - Lender's Book
     - Reservation Date
     - Lent Date
     - Return Date
     - Status
 - **User's inbox:**
     - Recipient ID
     - Type
     - Content
     - Timestamp
     - Read

**Project role assignment**

 - Database **Magdalena Rąpała:**
     - Baseline Schematics
     - Diagrams
     - Implementation of functional DB
     - Management
 - Application Backend **Piotr Copek:**
     - Architecture
     - Connectivity with Frontend and DB
     - APIs
 - Frontend **Zuzanna Micorek:**
     - Preliminary Design
     - Functional and Accessible Design
     - UI/UX
 - Tests **Miłosz Liniewiecki:**
     - Unit tests
     - Integration tests
     - Manual tests
 - Tools Setup and Integration **Jakub Zając:**
     - GitHub: merge, pull requests
     - Resolving tools problems
     - Code Reviews
     - Containerization
 - Documentation **Piotr Copek:**
     - Backend documentation
     - Reports
     - User manual

**Tech stack**

Database: `PostgreSQL`

Application backend: `Python Flask`

Frontend: `HTML CSS JS`

Tests: `Pytest`

Tools Setup and Integration: `Github Docker`

Documentation: `Markdown` [`Google Style Documentation`](https://google.github.io/styleguide/pyguide.html)
