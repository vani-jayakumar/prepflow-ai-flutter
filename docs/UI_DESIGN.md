# 🎨 UI_DESIGN.md — PrepFlow AI (DESIGN SYSTEM V2)

---

# 1. 🧠 Design Philosophy

*   **Premium & Unique**: High-end aesthetic driven by a custom Veridian & Seafoam palette.
*   **Layered Surfaces**: Using deep gunmetal and slate for depth rather than pure black.
*   **Glassmorphism**: Subtle translucency on secondary containers to create visual hierarchy.
*   **Dynamic Motion**: 300ms cubic-bezier transitions for interactive components.
*   **Intelligent Simplicity**: A focus-first UI that highlights AI-driven insights through vibrant gradients.

---

# 2. 🌈 COLOR SYSTEM

## 🌞 LIGHT MODE
### Background
*   **Primary Background**: `#F8FAFC` (Slate 50)
*   **Secondary Background**: `#FFFFFF` (White)
*   **Tertiary Background**: `#F1F5F9` (Slate 100)

### Brand Accents
*   **Primary Accent (Veridian)**: `#059669`
*   **Secondary Accent (Seafoam)**: `#10B981`
*   **Tertiary Accent (Sky)**: `#0EA5E9`

---

## 🌙 DARK MODE (Gunmetal System)
### Background
*   **Primary Background**: `#020617` (Deepest Slate / OLED-optimal)
*   **Secondary Background**: `#0F172A` (Gunmetal / Elevated surfaces)
*   **Tertiary Background**: `#1E293B` (Slate 800 / Highest elevation)

### Brand Accents
*   **Primary Accent (Veridian)**: `#059669`
*   **Secondary Accent (Teal)**: `#2DD4BF`
*   **Tertiary Accent (Sky)**: `#38BDF8`

---

## 🌊 Gradients (Premium Flow)
### Primary Gradient (Brand Identity)
*   **Light**: `Veridian (#059669) → Seafoam (#10B981)`
*   **Dark**: `Veridian (#059669) → Cyan (#2DD4BF)`

### Secondary Gradient (Support)
*   **Light**: `Sky (#0EA5E9) → Indigo (#6366F1)`
*   **Dark**: `Sky (#38BDF8) → Indigo (#818CF8)`

### Accent Gradient (Status/Highlight)
*   **Light**: `Amber (#F59E0B) → Rose (#F43F5E)`
*   **Dark**: `Amber (#FBBF24) → Rose (#FB7185)`

---

# 3. ✍️ TYPOGRAPHY SYSTEM (Inter)

## Scale
*   **Display Large**: 34px (Hero headlines, Welcome back)
*   **Display Medium**: 28px (Section hero, Tracker headers)
*   **H1**: 24px (Large titles)
*   **H2**: 22px (Main section headers)
*   **H3**: 20px (Subsection headers)
*   **H4**: 17px (Card titles, App bar)
*   **Body Large**: 17px (Primary content)
*   **Body Base**: 15px (Standard text)
*   **Body Small**: 14px (Secondary labels, Description)
*   **Caption**: 12px (Small helpers, Overlines)

---

# 4. 🧩 COMPONENT DESIGN

## Premium AppSwitch
*   **Logic**: Custom `AnimatedContainer` with 300ms easing.
*   **Style**: Pill-shaped track with a primary gradient when active.
*   **Detail**: High-elevation thumb shadow and translucent border when inactive.

## Glass Card (AppGlassCard)
*   **Radius**: 20px (Modern soft corners).
*   **Border**: 0.5px subtle hairline (`0.5 alpha Slate`).
*   **Fill**: `75% - 85%` opacity for "layered" transparency.

## AppButton
*   **Primary**: Fully rounded or 16px radius, Veridian background, White text.
*   **Secondary**: Transparent background with low-opacity accent borders.

---

# 5. 🎯 VISUAL PRIORITY RULES

*   **Gradients**: Reserve for **Match Scores**, **Roadmap Milestones**, and **Primary CTAs**.
*   **Glows**: Subtle `shadowAccent` (10% Veridian) for high-priority interactive components.
*   **Separation**: Use `darkSeparator` (`#334155`) sparingly; prioritize whitespace and background shifts.

---

# 6. ⚠️ DESIGN RULES

*   **❌ Avoid**: Pure indigo/violet as primary colors. Generic pure red/blue for status.
*   **✅ Follow**: Use **Veridian** for reliability and intelligence. Use **Seafoam** for success and progression.

---

# ✅ END OF UI DESIGN V2
