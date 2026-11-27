USE pantry_planner;

INSERT INTO ingredients (name_he, category, kosher_type, substitution_group, kcal_per_100g, protein_per_100g, is_packaged, package_weight_g, estimated_price_ils)
VALUES
('חזה עוף טרי', 'חלבונים ובשר', 'Meat', 'lean_meat', 165.00, 31.00, FALSE, NULL, 39.00),
('גבינת קוטג׳ 5%', 'מוצרי חלב', 'Dairy', 'soft_cheese', 98.00, 11.00, TRUE, 250.0, 6.90),
('אורז בסמטי מלא', 'דגנים ויבש', 'Parve', 'grains', 350.00, 7.50, TRUE, 1000.0, 12.50),
('ביצים L', 'חלבונים וביצים', 'Parve', 'eggs', 143.00, 12.60, TRUE, 720.0, 14.20);

INSERT INTO recipes (title_he, meal_type, prep_time_minutes, kosher_type, is_single_item, required_appliances, cooking_style_tags, instructions_text)
VALUES
('חזה עוף מוקפץ עם אורז וירקות', 'Lunch', 25, 'Meat', FALSE, '["stove"]', '["Batch Cooking", "Under 30 Mins"]', 'צולים חזה עוף במחבת ומגישים לצד אורז בסמטי מבושל.');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, required_grams, is_substitutable)
VALUES
(1, 1, 180.0, TRUE),
(1, 3, 100.0, TRUE);