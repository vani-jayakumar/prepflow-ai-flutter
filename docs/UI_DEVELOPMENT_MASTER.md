# 🚀 UI_DEVELOPMENT_MASTER.md — PrepFlow AI

---

# 1. 🧠 PURPOSE

This document instructs AI to:

👉 Convert HTML prototype → Full Flutter UI
👉 Generate ALL screens
👉 Follow strict MVVM + Riverpod architecture
👉 Maintain production-level code quality

---

# 2. ⚠️ GLOBAL RULES (STRICT — NO EXCEPTIONS)

---

## ❌ DO NOT

* Use `setState`
* Create private widgets inside screens
* Put business logic in UI
* Create files > 300 lines
* Hardcode colors, fonts, spacing
* Mix multiple screens in one file

---

## ✅ MUST FOLLOW

* MVVM architecture
* Riverpod (StateNotifier)
* Separate widgets into files
* Use reusable components
* Follow design system strictly

---

# 3. 📁 REQUIRED PROJECT STRUCTURE

---

```
lib/
 ├── core/
 │    ├── theme/
 │    ├── constants/
 │    ├── utils/
 │    ├── validators/
 │
 ├── shared/
 │    ├── widgets/
 │
 ├── features/
 │    ├── splash/
 │    ├── auth/
 │    ├── input/
 │    ├── dashboard/
 │    ├── skill_gap/
 │    ├── questions/
 │    ├── mock_interview/
 │    ├── tracker/
 │    ├── settings/
 │
 ├── app/
```

---

# 4. 🎨 DESIGN IMPLEMENTATION RULES

---

## Colors

* Use only AppColors
* No hex values in UI

---

## Typography

* Use AppTextStyles
* Maintain hierarchy (H1, H2, body)

---

## Spacing

* Use spacing constants only
* No random padding

---

## Components

* Cards → reusable
* Buttons → reusable
* Inputs → reusable

---

# 5. 📲 SCREEN GENERATION RULES

---

For EACH screen:

---

## Structure

```
feature/
 ├── view/
 │    ├── screens/
 │    ├── widgets/
```

---

## Screen File

* Only layout
* No large UI blocks
* Calls widgets

---

## Widget Files

* Each UI section separate
* Reusable
* Clean

---

# 6. 🧠 VIEWMODEL RULES

---

## Must Include

* Notifier (Freezed)
* State (.g.dart only)

---

## Rules

* No UI code
* No context usage
* Pure logic only

---

# 7. 📦 MODEL RULES

---

* Only simple Dart classes
* All fields nullable
* Use type converters
* No generated files

---

# 8. 🔁 HTML → FLUTTER CONVERSION RULES

---

AI must:

* Match UI EXACTLY from HTML
* Maintain:

  * Layout
  * Colors
  * Gradients
  * Spacing
  * Typography

---

## DO NOT

* Simplify UI
* Skip sections
* Change layout

---

# 9. 📲 SCREENS TO GENERATE

---

## AUTH

* Splash
* Login
* Register

---

## CORE

* Input Screen
* Dashboard
* Skill Gap
* Questions
* Mock Interview

---

## TRACKER

* Tracker main
* Add upcoming
* Log interview
* Interview report

---

## SETTINGS

* Settings
* Edit Profile

---

# 10. ⚙️ STATE MANAGEMENT RULES

---

* Use Riverpod
* Use StateNotifier
* Use Consumer only where needed
* Avoid full screen rebuild

---

# 11. 🔥 PERFORMANCE RULES

---

* Use const constructors
* Minimize rebuilds
* Use select() where needed

---

# 12. 🧩 COMMON COMPONENTS

---

Move to shared/widgets:

* AppButton
* AppCard
* AppTextField
* Chips
* ChatBubble
* GradientCard

---

# 13. 🚀 FINAL GENERATION INSTRUCTION

---

AI MUST:

* Generate ALL UI screens
* Follow feature-wise separation
* Create widget files per screen
* Maintain consistency across app

---

# 14. ❗ OUTPUT EXPECTATION

---

AI should generate:

* Complete UI layer
* Proper folder structure
* Modular widgets
* Clean architecture

---

# 15. 🔥 FINAL GOAL

---

Build a:

👉 Production-ready Flutter UI
👉 Fully scalable
👉 Clean architecture compliant

---

# ✅ END OF FILE
