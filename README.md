# 🚀 PrepFlow AI — Master Your Interviews with AI

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State-Riverpod_2.5-000000?logo=dart&logoColor=white)](https://riverpod.dev)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM-6366F1)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)

**PrepFlow AI** is an AI-powered preparation and tracking system designed to help you crack interviews efficiently. It turns your **Resume + JD + Company** into a complete ecosystem of personalized mock interviews, skill gap analysis, and structured learning.

---

## 🌟 Vision
PrepFlow AI bridges the gap between applying for a job and being fully prepared to crack it. It replaces generic practice with company-specific intelligence and real-time simulations.

## 💡 The Problem We Solve
Most candidates practice generic questions and miss company-specific expectations. PrepFlow AI solves this by:
- **Identifying Skill Gaps**: Real-time comparison of your Resume vs. the Job Description.
- **Simulating Reality**: AI-driven mock interviews that mimic real EM/Tech Lead sessions.
- **Consolidating Knowledge**: A personal question bank built from both AI generation and your past interview history.

---

## 🧩 Core Features

### 📊 1. Interview Readiness Dashboard
- **Compatibility Match**: Get a percentage-based score of how well your profile fits the role.
- **Strengths & Weaknesses**: Visual overview of your readiness progression.

### 🧠 2. AI Skill Gap Analysis & Fixer
- **Gap Engine**: Automatic extraction of requirements from JDs vs. your resume.
- **AI Roadmap**: A structured, day-by-day learning plan to master missing skills (e.g., GraphQL, System Design).

### 🎤 3. Mock Interview Engine
- **Chat-Based Simulation**: Real-time questioning and follow-up logic based on your answers.
- **AI Evaluation**: Immediate feedback on your responses with tips for improvement.

### 🆕 📅 Interview Tracker & Planner
- **Planner (Upcoming)**: Manage scheduled interviews, add notes, and generate targeted preparation.
- **History (Completed)**: Log past interviews to identifies repeated patterns and build a permanent personal question bank.

---

## 📱 Tech Stack

| Layer | Technologies |
| :--- | :--- |
| **Frontend** | Flutter (iOS + Android), MVVM Architecture |
| **State Management** | Riverpod 2.5 (Strictly no `setState`) |
| **Backend** | Firebase Auth, Firestore, Firebase Storage |
| **AI Layer** | OpenAI / Gemini API Integration |

---

## 🏗️ System Architecture
```text
Flutter App (UI Layer)
        ↓
Riverpod Notifiers (Logic/State Layer)
        ↓
Firebase & AI Processing (Data/Intelligence Layer)
```

## 📂 Project Structure
```text
lib/
 ├── core/      # Design system, theme, routing, and utils
 ├── features/  # Feature-based modular structure (Auth, Dashboard, Mock AI, etc.)
 ├── shared/    # Reusable UI widgets (AppGlassCard, AppButton, etc.)
 └── main.dart  # Application entry point
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Channel Stable)
- OpenAI / Gemini API Key
- Firebase Configuration

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/vani-jayakumar/prepflow-ai-flutter.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---

## 🧪 Future Enhancements
- 🎙️ **AI Voice Interviewer**: Switch from chat to real-time voice conversations.
- 🏢 **Company Intelligence**: Deep-dive hiring patterns for specific Fortune 500 companies.
- 📝 **Resume Improver**: AI-generated suggestions to boost your match score.

---

## 🧑‍💻 Development Principles
- **Clean Architecture**: Separation of concerns across all modules.
- **Reusable Components**: Tokenized design system for a "Premium" look.
- **Scalable State**: Riverpod usage ensures predictable data flow.

---

# ✅ END OF README
