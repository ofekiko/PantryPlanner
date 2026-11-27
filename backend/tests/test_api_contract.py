from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_health_check():
    res = client.get("/health")
    assert res.status_code == 200
    assert res.json()["status"] == "ok"


def test_generate_meal_plan_selected_days():
    payload = {
        "household_id": 1,
        "weekly_budget": 450.0,
        "plan_days": ["Sunday", "Monday", "Tuesday", "Wednesday"],
        "cooking_days": ["Sunday", "Wednesday"],
        "appliances": ["stove", "microwave", "oven", "toaster"],
        "kosher_mode": True,
    }
    res = client.post("/api/plans/generate", json=payload)
    assert res.status_code == 200
    data = res.json()
    assert data["total_estimated_cost"] <= payload["weekly_budget"]
    assert len(data["days"]) == len(payload["plan_days"])


def test_shopping_list_packaged_and_by_weight():
    res = client.get("/api/plans/1/shopping-list")
    assert res.status_code == 200
    items = res.json()["items"]
    assert len(items) > 0
    assert all(
        item["packages_to_buy"] >= 1 if item["is_packaged"] else item["grams_to_buy"] > 0
        for item in items
    )