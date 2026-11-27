from fastapi import FastAPI
from pydantic import BaseModel, Field
from typing import List, Optional

app = FastAPI(
    title="PantryPlanner API",
    description="Constraint-driven multi-day meal planning and grocery optimization engine",
    version="0.1.0",
)


class MealPlanRequest(BaseModel):
    household_id: int
    weekly_budget: float = Field(..., gt=0)
    plan_days: List[str] = Field(..., min_length=1)
    cooking_days: List[str]
    appliances: List[str]
    kosher_mode: bool = True


class MealSlotOut(BaseModel):
    day_name: str
    meal_type: str
    recipe_title: str
    calories: int
    protein_g: int
    is_leftover: bool = False


class MealPlanResponse(BaseModel):
    plan_id: int
    total_estimated_cost: float
    days: List[str]
    slots: List[MealSlotOut]


class ShoppingItemOut(BaseModel):
    ingredient_name: str
    is_packaged: bool
    packages_to_buy: Optional[int] = None
    grams_to_buy: Optional[float] = None
    estimated_cost_ils: float


class ShoppingListResponse(BaseModel):
    plan_id: int
    items: List[ShoppingItemOut]


@app.get("/health")
def health_check():
    return {"status": "ok", "service": "PantryPlanner API"}


@app.post("/api/plans/generate", response_model=MealPlanResponse)
def generate_meal_plan(payload: MealPlanRequest):
    # TODO: Connect PuLP MILP solver & MySQL pantry/recipe queries
    sample_slots = [
        MealSlotOut(
            day_name=day,
            meal_type="Lunch",
            recipe_title="חזה עוף מוקפץ עם אורז וירקות",
            calories=580,
            protein_g=48,
            is_leftover=(day not in payload.cooking_days),
        )
        for day in payload.plan_days
    ]
    return MealPlanResponse(
        plan_id=1,
        total_estimated_cost=min(385.0, payload.weekly_budget),
        days=payload.plan_days,
        slots=sample_slots,
    )


@app.get("/api/plans/{plan_id}/shopping-list", response_model=ShoppingListResponse)
def get_shopping_list(plan_id: int):
    # TODO: Fetch materialized shopping_items from MySQL
    return ShoppingListResponse(
        plan_id=plan_id,
        items=[
            ShoppingItemOut(
                ingredient_name="גבינת קוטג' 5%",
                is_packaged=True,
                packages_to_buy=2,
                estimated_cost_ils=13.80,
            ),
            ShoppingItemOut(
                ingredient_name="חזה עוף טרי",
                is_packaged=False,
                grams_to_buy=600.0,
                estimated_cost_ils=23.40,
            ),
        ],
    )