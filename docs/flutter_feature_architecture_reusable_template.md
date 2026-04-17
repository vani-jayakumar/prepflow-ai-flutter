# Flutter Feature Architecture (Reusable Template)

## 1. Overview

This document defines a **standard, reusable feature architecture** for Flutter applications using:

* MVVM-inspired structure
* Riverpod (code generation)
* Repository pattern
* Freezed (immutable state)
* Clean separation of concerns

This template can be applied to **any feature/module** (e.g., Stores, Products, Users, Orders).

---

## 2. Core Principles

### ❌ Avoid

* No `setState`
* No business logic inside UI
* No direct API calls from UI

### ✅ Enforce

* State handled only via **Notifier (ViewModel)**
* UI reacts using **Riverpod watch**
* Actions triggered using **read**
* Immutable state using Freezed
* Minimal Consumer usage (wrap only required widgets)

---

## 3. Folder Structure

```
feature_name/
│
├── model/
│   └── feature_model.dart
│
├── notifier/
│   ├── feature_notifier.dart
│   └── feature_notifier.g.dart
│
├── repo/
│   ├── feature_repo.dart
│   ├── feature_repo_query.dart
│   └── feature_repo.g.dart
│
├── state/
│   ├── feature_state.dart
│   └── feature_state.freezed.dart
│
└── view/
    ├── feature_screen.dart
    └── widget/
        ├── reusable_widget_1.dart
        ├── reusable_widget_2.dart
        └── ...
```

---

## 4. Layer Responsibilities

### 4.1 Model Layer

* Represents API data
* Handles JSON parsing
* No business logic

**Rules:**

* Use nullable fields where required
* Always provide `fromJson` and `toJson`
* Use safe parsing helpers

---

### 4.2 Repository Layer

* Handles API communication
* Uses GraphQL/REST
* Returns `Either<Error, Response>`

**Rules:**

* No UI logic
* No state management
* Only data fetching & parsing

---

### 4.3 State Layer (Freezed)

* Immutable state container
* Holds all UI + business state

**Rules:**

* Use `@freezed`
* Provide defaults where needed
* Keep it flat and readable

---

### 4.4 Notifier Layer (ViewModel)

* Central logic controller
* Connects Repo → State → UI

**Responsibilities:**

* Fetch data
* Transform data
* Handle selection
* Manage UI flags
* Update state using `copyWith`

**Rules:**

* No UI widgets
* No BuildContext
* Always update state immutably

---

### 4.5 View Layer (UI)

* Pure UI rendering
* No business logic

**Rules:**

* Use `ref.watch()` for reactive updates
* Use `ref.read()` for actions
* Avoid wrapping full screens with Consumer
* Wrap only necessary widgets

---

## 5. Riverpod Usage Guidelines

### watch vs read

| Usage         | Purpose                 |
| ------------- | ----------------------- |
| `ref.watch()` | Listen to state changes |
| `ref.read()`  | Trigger actions         |

### Example Pattern

```
final state = ref.watch(featureNotifierProvider);

onTap: () {
  ref.read(featureNotifierProvider.notifier).fetchData();
}
```

---

## 6. UI Composition Rules

### ❌ Bad Practice

* Wrapping entire screen with Consumer

### ✅ Good Practice

* Wrap only dynamic widgets

```
Consumer(
  builder: (context, ref, _) {
    final state = ref.watch(provider);
    return Text(state.value);
  },
)
```

---

## 7. Data Flow

```
UI (watch)
   ↓
Notifier (logic)
   ↓
Repository (API)
   ↓
Network Layer
   ↓
Response
   ↓
Notifier updates state
   ↓
UI rebuilds automatically
```

---

## 8. State Design Guidelines

Include:

* API response model
* UI selections
* Derived data
* Loader states
* Visibility flags

Example fields:

* selectedItem
* filteredList
* loadingState
* errorState

---

## 9. Naming Conventions

| Layer    | Naming                    |
| -------- | ------------------------- |
| Model    | `FeatureModel`            |
| Repo     | `FeatureRepo`             |
| State    | `FeatureState`            |
| Notifier | `FeatureNotifier`         |
| Provider | `featureNotifierProvider` |

---

## 10. Performance Guidelines

* Minimize rebuild scope
* Avoid unnecessary watch calls
* Use derived data in notifier instead of UI
* Keep widgets small and reusable

---

## 11. Scalability Rules

* Each feature is self-contained
* No cross-feature tight coupling
* Reusable widgets go to common module if needed

---

## 12. Summary

This architecture ensures:

* Clean separation of concerns
* Predictable state management
* Scalable feature development
* High maintainability
* Testability

This template should be used as a **standard guideline for all future features** in the project.

---

## 13. Practical Example (Reference Implementation)

### 13.1 Model Example

```dart
class FeatureModel {
  final String? id;
  final String? name;
  final String? description;
  final String? latitude;
  final String? longitude;
  final String? image;

  FeatureModel({
    this.id,
    this.name,
    this.description,
    this.latitude,
    this.longitude,
    this.image,
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: convertToString(json['id'] ?? ''),
      name: convertToString(json['name'] ?? ''),
      description: convertToString(json['description'] ?? ''),
      latitude: convertToString(json['latitude'] ?? ''),
      longitude: convertToString(json['longitude'] ?? ''),
      image: convertToString(json['image'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'image': image,
    };
  }
}
```

---

### 13.2 Repo Query Example (GraphQL)

```dart
class FeatureRepoQuery {
  String getFeatureQuery() {
    return '''
    {
      getAllItems {
        id
        name
        description
        latitude
        longitude
        image
      }
    }
    ''';
  }
}
```

---

### 13.3 Repository Example

```dart
@riverpod
class FeatureRepository extends _$FeatureRepository {
  @override
  FeatureRepo build() {
    return FeatureRepoImplement();
  }
}

abstract class FeatureRepo {
  Future<Either<ResponseError, FeatureResponseModel>> getData();
}

class FeatureRepoImplement implements FeatureRepo {
  final query = FeatureRepoQuery();

  @override
  Future<Either<ResponseError, FeatureResponseModel>> getData() {
    return graphQlServices
        .safe(
          graphQlServices.getRequest(endPoint: query.getFeatureQuery()),
        )
        .thenRight(graphQlServices.checkHttpStatus)
        .thenRight(graphQlServices.parseJson)
        .mapRight((right) => FeatureResponseModel.fromJson(right));
  }
}
```

---

### 13.4 State Example (Freezed)

```dart
@freezed
sealed class FeatureState with _$FeatureState {
  const factory FeatureState({
    FeatureResponseModel? response,
    List<FeatureModel>? items,
    FeatureModel? selectedItem,
    String? selectedText,
    @Default(true) bool showCard,
    @Default(LoaderState.loaded) LoaderState loaderState,
  }) = _FeatureState;
}
```

---

### 13.5 Notifier Example

```dart
@riverpod
class FeatureNotifier extends _$FeatureNotifier {
  @override
  FeatureState build() => const FeatureState();

  Future<void> fetchData() async {
    state = state.copyWith(loaderState: LoaderState.loading);

    final repo = ref.read(featureRepositoryProvider);
    final result = await repo.getData();

    result.fold(
      (error) {
        state = state.copyWith(loaderState: LoaderState.error);
      },
      (data) {
        state = state.copyWith(
          response: data,
          items: data.items,
          loaderState: LoaderState.loaded,
        );
      },
    );
  }

  void selectItem(FeatureModel item) {
    state = state.copyWith(
      selectedItem: item,
      selectedText: item.name,
      showCard: true,
    );
  }
}
```

---

### 13.6 UI Usage Example

#### Screen (Minimal Watch)

```dart
class FeatureScreen extends ConsumerWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(featureNotifierProvider);

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: FeatureList()),
        ],
      ),
    );
  }
}
```

---

#### Widget-Level Consumer (Best Practice)

```dart
class FeatureList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(featureNotifierProvider);

        return ListView.builder(
          itemCount: state.items?.length ?? 0,
          itemBuilder: (context, index) {
            final item = state.items![index];

            return ListTile(
              title: Text(item.name ?? ''),
              onTap: () {
                ref
                    .read(featureNotifierProvider.notifier)
                    .selectItem(item);
              },
            );
          },
        );
      },
    );
  }
}
```

---

### 13.7 Key Takeaways from Example

* No `setState` used anywhere
* UI is fully reactive via `watch`
* Actions are triggered via `read`
* Only required widgets are wrapped with `Consumer`
* Business logic stays inside Notifier

---

### 13.8 Optional Enhancements

* Add pagination support in notifier
* Add caching layer in repo
* Add error-specific UI states
* Extract common widgets into shared module

---

This example mirrors the exact structure you provided and can be reused across all features.
