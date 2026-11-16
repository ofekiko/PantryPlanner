# PantryPlanner

**PantryPlanner** is an automated, constraint-driven weekly meal and grocery planner designed to optimize daily nutrition targets (calories and protein) while minimizing food waste and staying within a weekly supermarket budget.

## Core Capabilities
- **Goal & Budget Configuration:** Define daily calorie/macro targets, dietary exclusions, and weekly budget limits.
- **Pantry & Expiration Tracking:** Manage existing home inventory and prioritize ingredients nearing expiration.
- **Two-Layered Optimization Engine:** Generates balanced weekly meal plans combining complete recipes and standalone food items.
- **Whole-Package Shopping List:** Calculates only missing ingredients rounded to realistic supermarket package sizes.
- **Meal Swapping & Daily Tracking:** Swap meals with nutritionally equivalent alternatives and log actual daily intake.

## Planned Architecture & Tech Stack
- **Optimization & Backend:** Python (MILP Solver), REST API
- **Database:** MySQL (Relational schema for recipes, pantry inventory, and store packages)
- **Data Sources:** Israeli Ministry of Health Nutrition Database & Open Food Facts (Open Data)
- **Frontend:** RTL-supported Web Interface

## Repository Structure
- `backend/` – Optimization engine, API endpoints, and ETL scripts
- `frontend/` – Web client UI
- `db/` – MySQL schema definitions (`CREATE TABLE`) and seed scripts
- `docs/` – Architectural diagrams, decision logs, and test plans
