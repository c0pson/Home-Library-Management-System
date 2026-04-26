## Home Library Management System

Project for managing personal books collections with lending and reservation features.

### Features

- User accounts and friend connections
- Book collection management
- Lending and reservation system
- Inbox notifications
- Search and sorting of books

### Tech Stack

- **Database:** `PostgreSQL`
- **Backend:** `Python Flask`
- **Frontend:** `HTML, CSS, JavaScript`
- **Testing:** `Pytest`
- **Tools:** `GitHub, Docker`

### Project structure

```
project-root/
│
├── database/
│   ├── schema/
│   │   ├── create_tables.sql
│   │   ├── drop_tables.sql
│   │   └── indexes.sql
│   ├── functions/
│   │   └── procedures.sql
│   └── setup.py
│
├── app/
│   ├── config/
│   │   └── config.py
│   │
│   ├── database/
│   │   ├── connection.py
│   │   ├── models/
│   │   │   ├── user.py
│   │   │   ├── book.py
│   │   │   ├── lending.py
│   │   │   └── inbox.py
│   │   └── repositories/
│   │       ├── user_repo.py
│   │       ├── book_repo.py
│   │       ├── lending_repo.py
│   │       └── inbox_repo.py
│   │
│   ├── api/
│   │   ├── routes/
│   │   │   ├── user_routes.py
│   │   │   ├── book_routes.py
│   │   │   ├── lending_routes.py
│   │   │   └── inbox_routes.py
│   │   └── schemas/
│   │       ├── user_schema.py
│   │       ├── book_schema.py
│   │       ├── lending_schema.py
│   │       └── inbox_schema.py
│   │
│   ├── services/
│   │   ├── user_service.py
│   │   ├── book_service.py
│   │   ├── lending_service.py
│   │   └── inbox_service.py
│   │
│   ├── utils/
│   │   └── security.py
│   │
│   ├── templates/              # Jinja2 HTML templates
│   │   ├── base.html
│   │   ├── login.html
│   │   ├── dashboard.html
│   │   ├── books.html
│   │   ├── lending.html
│   │   └── inbox.html
│   │
│   ├── static/                 # CSS, JS, assets
│   │   ├── css/
│   │   ├── js/
│   │   └── img/
│   │
│   └── __init__.py
│
├── tests/
│   ├── unit/
│   ├── integration/
│   └── conftest.py
│
├── docker/
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── docs/
│   └── README.md
│
├── main.py
├── requirements.txt
├── .gitignore
├── LICENSE
└── README.md
```

### Running with Docker

Start Docker Desktop, then from the project root:

```bash
# Build and start
docker compose -f docker/compose.yaml up --build

# Stop (data kept)
docker compose -f docker/compose.yaml down

# Stop and wipe database
docker compose -f docker/compose.yaml down -v
```

Backend runs at `http://localhost:8000`.

### Documentation

 - [Initial System Requirements Specification](docs/Initial_System_Requirements_Specification.md)
