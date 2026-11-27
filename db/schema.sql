CREATE DATABASE IF NOT EXISTS pantry_planner CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pantry_planner;

CREATE TABLE households (
    household_id INT AUTO_INCREMENT PRIMARY KEY,
    weekly_budget_ils DECIMAL(8,2) NOT NULL,
    track_macros BOOLEAN NOT NULL DEFAULT TRUE,
    kosher_mode BOOLEAN NOT NULL DEFAULT FALSE,
    available_appliances JSON NOT NULL,
    cooking_effort_styles JSON NOT NULL,
    designated_cooking_days JSON NOT NULL,
    selected_plan_days JSON NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE diners (
    diner_id INT AUTO_INCREMENT PRIMARY KEY,
    household_id INT NOT NULL,
    full_name VARCHAR(80) NOT NULL,
    goal_mode ENUM('Bulk', 'Cut', 'Maintain') NOT NULL DEFAULT 'Maintain',
    weight_kg DECIMAL(5,1) NOT NULL,
    daily_calories_target INT NOT NULL,
    daily_protein_target_g INT NOT NULL,
    excluded_ingredient_ids JSON NOT NULL,
    daily_supplements JSON NOT NULL,
    FOREIGN KEY (household_id) REFERENCES households(household_id) ON DELETE CASCADE
);

CREATE TABLE ingredients (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    name_he VARCHAR(120) NOT NULL,
    category VARCHAR(60) NOT NULL,
    kosher_type ENUM('Meat', 'Dairy', 'Parve') NOT NULL DEFAULT 'Parve',
    substitution_group VARCHAR(50),
    kcal_per_100g DECIMAL(6,2) NOT NULL,
    protein_per_100g DECIMAL(6,2) NOT NULL,
    is_packaged BOOLEAN NOT NULL DEFAULT TRUE,
    package_weight_g DECIMAL(8,1),
    estimated_price_ils DECIMAL(7,2) NOT NULL
);

CREATE TABLE recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    title_he VARCHAR(120) NOT NULL,
    meal_type ENUM('Breakfast', 'Lunch', 'Dinner', 'Snack') NOT NULL,
    prep_time_minutes INT NOT NULL,
    kosher_type ENUM('Meat', 'Dairy', 'Parve') NOT NULL DEFAULT 'Parve',
    is_single_item BOOLEAN NOT NULL DEFAULT FALSE,
    required_appliances JSON NOT NULL,
    cooking_style_tags JSON NOT NULL,
    instructions_text TEXT
);

CREATE TABLE recipe_ingredients (
    recipe_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    required_grams DECIMAL(7,1) NOT NULL,
    is_substitutable BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT
);

CREATE TABLE pantry_inventory (
    pantry_id INT AUTO_INCREMENT PRIMARY KEY,
    household_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    quantity_grams DECIMAL(8,1) NOT NULL,
    expiration_date DATE NULL,
    is_recurring_staple BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (household_id) REFERENCES households(household_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE CASCADE
);

CREATE TABLE meal_plans (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    household_id INT NOT NULL,
    start_date DATE NOT NULL,
    selected_days_count INT NOT NULL,
    total_estimated_cost_ils DECIMAL(8,2) NOT NULL,
    optimization_status ENUM('Optimal', 'Feasible') NOT NULL DEFAULT 'Optimal',
    FOREIGN KEY (household_id) REFERENCES households(household_id) ON DELETE CASCADE
);

CREATE TABLE meal_slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    recipe_id INT NOT NULL,
    leftover_source_slot_id INT NULL,
    day_name VARCHAR(20) NOT NULL,
    meal_type ENUM('Breakfast', 'Lunch', 'Dinner', 'Snack') NOT NULL,
    portion_multiplier DECIMAL(4,2) NOT NULL DEFAULT 1.00,
    is_eaten BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (plan_id) REFERENCES meal_plans(plan_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipes(recipe_id) ON DELETE RESTRICT,
    FOREIGN KEY (leftover_source_slot_id) REFERENCES meal_slots(slot_id) ON DELETE SET NULL
);

CREATE TABLE shopping_items (
    shopping_item_id INT AUTO_INCREMENT PRIMARY KEY,
    plan_id INT NOT NULL,
    ingredient_id INT NOT NULL,
    packages_to_buy INT NULL,
    grams_to_buy DECIMAL(8,1) NULL,
    estimated_cost_ils DECIMAL(7,2) NOT NULL,
    is_checked BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (plan_id) REFERENCES meal_plans(plan_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(ingredient_id) ON DELETE RESTRICT
);