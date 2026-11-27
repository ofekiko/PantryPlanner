# PantryPlanner 🥗🛒

**Constraint-Driven Multi-Day Meal Planning & Grocery Optimization Engine**

PantryPlanner is a full-stack web application that automates household meal planning and grocery list generation. Instead of static recipe browsing, the system uses **Mixed-Integer Linear Programming (MILP)** to generate multi-day meal plans tailored to individual diners' calorie/protein targets, existing home pantry inventory (prioritizing near-expiration items), kitchen appliances, kosher rules, and a strict weekly budget.

---

## Key Engineering Highlights

* **Mathematical Optimization (MILP):** Formulates meal selection, portion scaling, and batch-cooking leftovers as a constrained optimization problem using **PuLP / SciPy** to hit macro targets while minimizing food waste and supermarket spend.
* **Inventory-First & Expiration Priority:** Deducts existing pantry ingredients before generating shopping items and prioritizes ingredients approaching their expiration date.
* **Realistic Supermarket Rounding:** Distinguishes between packaged goods (rounded up to whole store packages via Open Food Facts metadata) and deli/produce items purchased by weight (grams).
* **Household & Dietary Constraints:** Supports multi-diner households with separate macro goals, ingredient allergies/dislikes, kosher separation rules, available kitchen appliances, and custom cooking vs. leftover days.
* **Hebrew RTL Interface:** Designed with a clean, step-by-step Right-to-Left user workflow.

---

## System Architecture & UI Preview

### System Component Architecture
![System Architecture](docs/architecture_diagram.png)

### Interface Workflow (UI Mockups)
| Profile & Macro Targets | Kitchen & Cooking Schedule | Home Pantry & Expiration |
| :---: | :---: | :---: |
| ![Profile](docs/mockups/01_profile.png) | ![Kitchen](docs/mockups/02_kitchen.png) | ![Pantry](docs/mockups/03_pantry.png) |

| Multi-Day Meal Plan | Smart Shopping List | Daily Intake Tracker |
| :---: | :---: | :---: |
| ![Meal Plan](docs/mockups/04_meal_plan.png) | ![Shopping List](docs/mockups/05_shopping_list.png) | ![Daily Tracker](docs/mockups/06_daily_tracker.png) |

---

## Tech Stack

* **Backend & REST API:** Python 3.13, FastAPI, Pydantic
* **Optimization Solver:** PuLP, SciPy (MILP)
* **Database:** MySQL 8.0 (Relational schema with JSON constraint columns)
* **Frontend:** React, JavaScript, HTML, CSS (RTL layout)
* **External Data Sources:** Israeli Ministry of Health (MoH) Nutrition Database, Open Food Facts API

---

## Project Roadmap & Current Status

- [x] **System Architecture & Specification:** Component architecture, API contract design, and RTL UI wireframes.
- [x] **Relational Database Design:** Normalized MySQL schema supporting multi-diner profiles, pantry inventory, batch leftovers, and materialized shopping lists.
- [ ] **Backend & Data Ingestion (In Progress):** FastAPI endpoints and ETL pipeline for Israeli MoH nutrition data.
- [ ] **MILP Optimization Engine:** Solver implementation for budget, macro, and expiration constraints.
- [ ] **Frontend Integration:** Connecting the React RTL interface to the REST API.
