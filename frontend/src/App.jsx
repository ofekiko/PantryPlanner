import React, { useState } from "react";

const STEPS = [
  "פרופיל ויעדים",
  "המטבח שלי",
  "המזווה שלי",
  "תפריט רב-יומי",
  "רשימת קניות",
  "מעקב יומי",
];

export default function App() {
  const [activeStep, setActiveStep] = useState(0);

  return (
    <div dir="rtl" className="app-shell">
      <header>
        <h1>PantryPlanner</h1>
        <nav>
          {STEPS.map((label, idx) => (
            <button
              key={label}
              onClick={() => setActiveStep(idx)}
              aria-current={activeStep === idx ? "step" : undefined}
            >
              {label}
            </button>
          ))}
        </nav>
      </header>
      <main>
        <h2>{STEPS[activeStep]}</h2>
        <p>ממשק תכנון תפריטים וניהול קניות מבוסס אילוצים.</p>
      </main>
    </div>
  );
}