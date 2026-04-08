# 🚀 PrepFlow AI - Master Your Interviews with AI

**PrepFlow AI** is a premium, high-fidelity Flutter application designed to revolutionize interview preparation. By leveraging AI-driven insights, it parses your resume, analyzes job descriptions, and generates a custom roadmap to bridge your skill gaps.

![Logo](assets/logo.png)

## ✨ Premium Features

- **📊 AI Skill Gap Engine**: Automatically extracts keywords from resumes and JDs to identify missing requirements.
- **🗺️ Interactive Roadmaps**: Generates a day-by-day study plan with high-priority modules.
- **🤖 AI-Driven Mock Interviews**: Real-time chat interface with a simulated interviewer (Senior EM, Tech Lead, etc.).
- **📚 Smart Question Bank**: Curated technical and behavioral questions with priority tagging.
- **📅 Interview Lifecycle Tracker**: Schedule upcoming interviews and log past experiences to build your study bank.
- **💎 Premium Glassmorphism UI**: High-fidelity design with vibrant gradients, blurred cards, and smooth micro-animations.

## 🏗️ Architecture

Built with a focus on modularity, scalability, and maintainability:

- **Framework**: [Flutter 3.24+](https://flutter.dev)
- **State Management**: [Riverpod 2.5](https://riverpod.dev)
- **Navigation**: [GoRouter 14+](https://pub.dev/packages/go_router)
- **Pattern**: [MVVM (Model-View-ViewModel)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel)
- **Styling**: Centralized Design System with Dark/Light mode support.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Channel Stable)
- Android Studio / VS Code with Flutter extension

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

## 📂 Folder Structure
```text
lib/
├── core/            # Theme, Routing, Constants, Utils
├── features/        # Feature-based modular structure
│   ├── auth/        # Login/Register
│   ├── dashboard/   # Overview & progress
│   ├── mock_ai/     # Interview simulator
│   └── ...          # Other features
├── shared/          # Reusable UI widgets and components
└── main.dart        # Entry point
```

---

*Phase 1 Complete: All UI modules and navigation flows are successfully migrated from the HTML prototype to Flutter.*
