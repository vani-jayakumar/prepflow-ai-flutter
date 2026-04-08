# 🚀 FRONTEND_ARCHITECTURE.md — PrepFlow AI (ULTIMATE STRICT VERSION)

---

# 1. 🧠 Architecture Overview

* Pattern: **Lightweight MVVM**
* State Management: **Riverpod (StateNotifier)**
* State: **Freezed + `.g.dart` ONLY**
* Models: **Manual parsing (NO code generation)**
* UI: Fully modular, no inline widgets

---

# 2. 🏗️ Feature Structure (FINAL)

```plaintext
feature_name/
 ├── view/
 │   ├── screens/
 │   └── widgets/
 │
 ├── viewmodel/
 │   ├── feature_notifier.dart
 │   ├── feature_state.dart
 │   ├── feature_state.g.dart
 │   └── feature_notifier.freezed.dart
 │
 └── model/
     └── feature_model.dart
```

---

# 3. 📱 UI LAYER RULES (STRICT)

---

## Screen Rules

* Max **250–300 lines**
* ❌ No private widgets (`_Widget`)
* Split UI into multiple widget classes

---

## Widget Rules

* Reusable → `shared/widgets/`
* Feature-specific → `feature/view/widgets/`
* UI only — no logic

---

# 4. 🧠 STATE MANAGEMENT

---

## 4.1 State Rules

* Must use **Freezed**
* Must generate:

```plaintext
feature_state.g.dart
```

---

## Example

```dart
@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState({
    bool? isLoading,
    int? matchScore,
    String? error,
  }) = _DashboardState;

  factory DashboardState.fromJson(Map<String, dynamic> json) =>
      _$DashboardStateFromJson(json);
}
```

---

## 4.2 Notifier Rules

* All business logic here
* Handles:

  * API calls
  * Data mapping
  * Error handling

---

## Example

```dart
class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier() : super(const DashboardState());

  Future<void> fetchData() async {
    state = state.copyWith(isLoading: true);

    try {
      state = state.copyWith(
        isLoading: false,
        matchScore: 85,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
```

---

# 5. 🔌 PROVIDER RULE

---

* ❌ No separate provider files
* Declare near Notifier

```dart
final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  (ref) => DashboardNotifier(),
);
```

---

# 6. ⚡ WATCH vs READ (MANDATORY)

---

## watch → UI

```dart
final state = ref.watch(dashboardProvider);
```

---

## read → actions

```dart
ref.read(dashboardProvider.notifier).fetchData();
```

---

## PERFORMANCE

```dart
final score = ref.watch(
  dashboardProvider.select((s) => s.matchScore),
);
```

---

# 7. 🎯 CONSUMER RULE

---

* Wrap **only smallest UI parts**
* Avoid full rebuilds

---

# 8. 🧩 SHARED STRUCTURE

```plaintext
shared/
 ├── widgets/
 ├── constants/
 ├── validators/
 ├── converters/
 ├── theme/
 └── extensions/
```

---

# 9. 🔢 TYPE CONVERTERS (MANDATORY)

---

## RULE

* Never trust API types
* Always use safe conversion

---

## Example

```dart
int? convertToInt(dynamic valArg, {int defValue = 0}) { ... }
double? convertToDouble(dynamic valArg, {double defValue = 0.0}) { ... }
bool? convertToBool(dynamic val) { ... }
String? convertToString(dynamic valArg) { ... }
Map<String, dynamic> convertToMap(dynamic valArg) { ... }
List<T> convertToList<T>(dynamic valArg) { ... }
```

---

# 10. 📦 MODEL RULES (FINAL)

---

## STRICT RULES

* ❌ No `.g.dart`
* ❌ No code generation
* ❌ No required fields
* ✅ All fields optional
* ✅ Manual parsing only
* ✅ Use converters ALWAYS

---

## Example

```dart
class ProposedTimeAvailabilityDto {
  final bool? everyoneCanAttend;
  final int? availableCount;
  final int? totalCount;

  ProposedTimeAvailabilityDto({
    this.everyoneCanAttend,
    this.availableCount,
    this.totalCount,
  });

  factory ProposedTimeAvailabilityDto.fromJson(Map<String, dynamic> json) {
    return ProposedTimeAvailabilityDto(
      everyoneCanAttend: convertToBool(json['everyone_can_attend']),
      availableCount: convertToInt(json['available_count']),
      totalCount: convertToInt(json['total_count']),
    );
  }
}
```

---

# 11. 🎨 THEME SYSTEM

---

## Colors

```dart
class AppColors {
  static const primary = Color(0xFF4F46E5);
}
```

---

## Typography

```dart
class AppTextStyles {
  static const heading = TextStyle(fontSize: 20);
}
```

---

# 12. ✅ VALIDATORS

---

```dart
class Validators {
  static String? validateEmail(String value) {
    if (value.isEmpty) return "Required";
    return null;
  }
}
```

---

# 13. 🚫 STRICT RULES

---

## ❌ NEVER

* setState
* Private widgets in screens
* Required fields in models
* JSON parsing without converters
* Model code generation

---

## ✅ ALWAYS

* Use Riverpod correctly
* Keep UI modular
* Use safe converters
* Keep models nullable

---

# 14. 🔥 BEST PRACTICES

* Small widgets
* Feature isolation
* Selective rebuilds (`select`)
* Clean imports
* Consistent naming

---

# 15. 🎯 FINAL GOAL

Build a:

> Highly scalable, API-safe, performance-optimized Flutter app with strict MVVM discipline

---

# ✅ END OF ARCHITECTURE
