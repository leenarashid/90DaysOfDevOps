# 🚀 SwiftBite – Food Delivery Application

SwiftBite is a feature-rich, full-stack food delivery web application built entirely with Python using the **Flask** framework. It implements a complete e-commerce flow from user authentication and restaurant browsing to real-time cart management and order tracking.

---

## 🎯 Architecture & Technologies

At its core, SwiftBite uses a standard Flask "Application Factory" pattern with Blueprints for modularity.

*   **Backend Framework:** Flask 3.1
*   **Database ORM:** SQLAlchemy 2.1 mapped to MySQL via PyMySQL
*   **Authentication:** Flask-Login & Werkzeug Security Hashers
*   **Template Engine:** Jinja2
*   **Form Handling:** Flask-WTF
*   **Frontend Design:** Custom Vanilla CSS & ES6 JavaScript

---

## 📂 Project Structure & Python Code Deep-Dive

The application is structured inside an `app/` directory, treating the entire web server as a Python package. 

```text
├── app/
│   ├── __init__.py        # App factory and configuration
│   ├── models.py          # SQLAlchemy database schema declarations
│   ├── seed.py            # Initial dataset generator for development
│   ├── routes/            # Blueprint route definitions (Controllers)
│   │   ├── admin.py       # Admin dashboard & order status management
│   │   ├── auth.py        # Login/Registration & session handling
│   │   ├── main.py        # Public facing views (Home, Restaurant Menus)
│   │   └── orders.py      # Cart logic and secure checkout process
│   ├── static/            # Static assets (CSS/JS/Images)
│   └── templates/         # Jinja2 HTML View templates
├── docker-compose.yml     # Multi-container orchestration (Web + DB)
├── Dockerfile             # Python application container instructions
├── requirements.txt       # Python dependencies list
└── run.py                 # Application boot script
```

---

## 🐍 Understanding the Python Codebase

### 1. The Application Factory (`app/__init__.py`)
Instead of creating a global `app` variable, SwiftBite uses an **App Factory** pattern. The `create_app()` function runs on boot, sets up configurations (loading `.env` secrets), initializes extensions (like `db` and `login_manager`), and registers all Route Blueprints. This makes testing and deploying significantly easier.

### 2. Database Schema (`app/models.py`)
This file defines the application's entire database structure using Python classes, which SQLAlchemy translates into MySQL tables.
*   **`User`**: Implements `UserMixin` for Flask-Login integration. Handles passwords securely using `werkzeug.security.generate_password_hash`. Includes a boolean `is_admin` flag.
*   **`Restaurant` & `MenuItem`**: A one-to-many relationship defining the platform's catalog.
*   **`Order` & `OrderItem`**: The core transactional models. An `Order` calculates its `total_amount` based on relationships to `OrderItem`, which are snapshot copies of `MenuItem` prices at the time of purchase.

### 3. Route Blueprints (`app/routes/`)
Routes act as the **Controllers** in the MVC pattern. They connect the Database Models to the HTML Templates.
*   **`auth_bp`**: Manages POST requests for `/login` and `/register`. Uses decorators like `@login_required` to secure routes.
*   **`main_bp`**: Handles the public `/` homepage (loading all restaurants) and the detailed `/restaurant/<int:id>` menu pages.
*   **`orders_bp`**: Processes the JSON payload from the frontend shopping cart, validates the menu items against the database, creates a new `Order`, commits the transaction, and redirects to the order status tracker.
*   **`admin_bp`**: Secured via a custom `@admin_required` decorator check, this allows privileged users to update the status of active orders.

### 4. Database Seeding (`app/seed.py`)
To make testing easier without needing a real UI to create restaurants, this script runs via `run.py` on startup. It generates synthetic data (mock users, burgers, pizzas) and uses `db.session.add_all()` to inject them into the MySQL container.

---

## 🌟 How the Frontend Connects to Python

While standard HTML strings could be returned, SwiftBite uses **Jinja2 Templates** (`app/templates/`).

When you hit a route like `@main_bp.route('/')`, the Python code queries the database:
```python
restaurants = Restaurant.query.all()
return render_template('main/index.html', restaurants=restaurants)
```
Jinja2 then intercepts this return, takes the `restaurants` Python array, and dynamically builds an HTML grid using `{% for restaurant in restaurants %}` loops *before* sending it to the user's browser!

---

## 🚀 Running the Code

The simplest way to run both the Python code and the necessary MySQL database is via Docker Compose:

```bash
docker-compose up --build -d
```
The app will automatically run its Python dependency installations, establish database drivers, run the `seed.py` data injection, and launch the Flask server at: **http://localhost:5000**
