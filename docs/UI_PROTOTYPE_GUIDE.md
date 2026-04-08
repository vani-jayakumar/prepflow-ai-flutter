# 🎨 UI_PROTOTYPE_GUIDE.md — PrepFlow AI

---

# 1. 🧠 Purpose

This document defines how AI should generate:

👉 Interactive HTML prototype for the app

The prototype must:

* Represent real mobile UI
* Be screen-by-screen structured
* Be editable and reviewable
* Match final Flutter UI

---

# 2. 📱 PROTOTYPE REQUIREMENTS

---

## 2.1 General Rules

* Each screen must be a **separate section**
* Use **mobile frame layout**
* Simulate real app navigation
* Maintain consistent spacing and styling

---

## 2.2 Structure

```
HTML
 ├── Global Styles
 ├── Theme Variables (Light + Dark)
 ├── Phone Frame
 ├── Screens
 │    ├── Splash
 │    ├── Input Screen
 │    ├── Dashboard
 │    ├── Skill Gap
 │    ├── Questions
 │    ├── Mock Interview
 │    ├── Interview Tracker
 │    ├── Settings
```

---

# 3. 🎨 DESIGN SYSTEM (MANDATORY)

---

## 3.1 Theme Style

Use:

👉 Soft Gradient + Glass UI + Rounded cards

Inspired by:

* Modern iOS apps
* Premium fintech UI
* Smooth gradients

---

## 3.2 Color System

### Light Theme

* Background → Soft white (#F8FAFC)
* Card → #FFFFFF
* Primary → Indigo (#4F46E5)
* Accent → Purple gradient
* Text → Dark (#0F172A)

---

### Dark Theme

* Background → #0F172A
* Card → #1E293B
* Primary → Indigo (#6366F1)
* Accent → Purple + Blue gradient
* Text → White

---

## 3.3 UI Style Rules

* Border radius → 16–24px
* Soft shadows
* Gradient cards
* Minimal borders
* Clean typography

---

# 4. 📲 SCREEN DEFINITIONS

---

# 🔹 4.1 SPLASH SCREEN

### UI:

* Center logo
* App name
* Gradient background

---

# 🔹 4.2 INPUT SCREEN

### Sections:

* Upload Resume
* Paste JD
* Enter Company

### UI:

* Card-based inputs
* CTA button → “Analyze”

---

# 🔹 4.3 DASHBOARD

### Sections:

* Match Score
* Readiness Score
* Strengths
* Weakness

### UI:

* Large gradient card (score)
* Horizontal cards for insights

---

# 🔹 4.4 SKILL GAP SCREEN

### Sections:

* Missing Skills
* Weak Skills
* Strong Skills

### UI:

* Chips / tags
* Expandable cards

---

# 🔹 4.5 QUESTION SCREEN

### Sections:

* Technical
* HR
* Company-specific

### UI:

* Expandable question cards

---

# 🔹 4.6 MOCK INTERVIEW SCREEN

### UI:

* Chat interface
* AI messages
* User responses

---

# 🔹 4.7 INTERVIEW TRACKER (NEW FEATURE)

---

## A. Attended Interviews

Fields:

* Company Name
* Date
* Questions asked
* Notes

UI:

* Timeline cards
* Expandable details

---

## B. Scheduled Interviews

Fields:

* Company Name
* Date
* Role
* Notes

UI:

* Calendar-style cards
* Upcoming highlight

---

# 🔹 4.8 SETTINGS

* Profile
* Theme toggle
* Preferences

---

# 5. 🔄 NAVIGATION RULES

---

## Bottom Navigation Tabs

* Home
* Questions
* Mock Interview
* Tracker
* Profile

---

## Navigation Behavior

* Smooth transitions
* No page reload simulation
* Tap-based navigation

---

# 6. ⚙️ INTERACTION RULES

---

* Buttons must have hover/tap effect
* Cards clickable
* Scrollable content
* Sticky headers if needed

---

# 7. 🧠 AI GENERATION RULES

---

When generating HTML:

❌ DO NOT:

* Use random UI
* Mix styles
* Add unnecessary elements

---

✅ MUST:

* Follow exact screen structure
* Use consistent theme
* Keep mobile-first layout
* Use reusable classes

---

# 8. 🎯 OUTPUT EXPECTATION

AI must generate:

* Full HTML file
* All screens included
* Navigation working
* Clean UI

---

# 9. 🔥 FINAL GOAL

This HTML acts as:

👉 UI blueprint for Flutter app

---

# ✅ END OF FILE
