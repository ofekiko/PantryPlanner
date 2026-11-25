# PantryPlanner

**PantryPlanner** is an automated, constraint-driven weekly meal and grocery planner designed to optimize daily nutrition targets (calories and protein) while minimizing food waste and staying within a weekly supermarket budget.

## Core Capabilities
- **Flexible Goal, BMI/TDEE & Mode Configuration:** Includes a built-in BMI & TDEE calculator (factoring in job activity and workouts), Bulk/Cut/Maintenance goal modes with weekly weigh-in adjustments, multi-person household scaling, or a simplified budget-and-pantry-only mode without macro tracking.
- **Granular Dietary, Kosher & Kitchen Constraints:** Enforces kosher meat/dairy separation, medical allergies, and personal ingredient dislikes, while filtering recipes by available kitchen appliances (stove, microwave, oven, blender, toaster, air fryer) and cooking style (under 30 mins, batch cooking, minimal dishes, light/simple meals).
- **Custom Cooking Schedules & Variety Controls:** Allows users to select specific cooking days (assigning batch-cooked leftovers to non-cooking days while maintaining full daily meal coverage), set weekly meal repeat limits, and rate or block dishes.
- **Smart Pantry & Expiration Management:** Tracks home inventory, supports recurring pantry staples ("always in stock"), triggers near-expiration alerts with one-click meal inclusion, and offers a "what's in my fridge" instant recipe matcher.
- **Two-Layered Optimization Engine:** Generates balanced weekly meal plans combining complete recipes and standalone food items.
- **Whole-Package Shopping List:** Calculates missing ingredients across all household diners rounded to realistic supermarket package sizes.
- **Meal Swapping & Daily Tracking:** Swap meals with nutritionally equivalent alternatives and log actual daily intake alongside off-plan items.

## Planned Roadmap (v2)
- **Supermarket Price Comparison & Cart Export:** Compare total weekly basket costs across Israeli supermarket chains and export shopping lists directly to online supermarket carts.
- **Automated Pantry & Recipe Capture:** Add items via barcode scanning or supermarket receipt OCR, and import custom recipes from web URLs or free text with automatic macro calculation.
- **Connected Ecosystem:** Real-time multi-user sync for shared household pantries/shopping lists and smartwatch step/calorie synchronization.

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
