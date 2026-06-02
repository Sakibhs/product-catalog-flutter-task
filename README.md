# Product Catalog App

A Flutter application that displays products from the Fake Store API. The app allows users to browse products, search products by title, view product details, and save favorite products locally.

---

# Features

* Product Listing Screen
* Product Details Screen
* Search Products by Title
* Favorites Management
* Persistent Favorites using SharedPreferences
* Loading State Handling
* Error State Handling with Retry
* Empty State Handling
* Clean Architecture using MVVM
* GetX State Management

---

# API Used

Products are fetched from:

https://fakestoreapi.com/products

---

# Project Setup Instructions

## Prerequisites

Ensure the following are installed:

* Flutter SDK (latest stable version)
* Dart SDK
* Android Studio / VS Code
* Android Emulator or Physical Device

Check Flutter installation:

```bash
flutter doctor
```

---

## Clone the Project

```bash
git clone <repository-url>
cd product_catalog
```

---

## Install Dependencies

```bash
flutter pub get
```

---

## Run the Application

```bash
flutter run
```

---

## Build APK

```bash
flutter build apk
```

---

# Project Structure

```text
lib/
│
├── app/
│   │
│   ├── bindings/
│   │   └── initial_binding.dart
│   │
│   ├── data/
│   │   ├── models/
│   │   ├── providers/
│   │   └── repositories/
│   │
│   ├── modules/
│   │   ├── home/
│   │   ├── product_details/
│   │   └── favorites/
│   │
│   ├── routes/
│   │
│   ├── services/
│   │   └── favorite_service.dart
│   │
│   └── widgets/
│
└── main.dart
```

---

# Architecture Explanation

This project follows the MVVM (Model-View-ViewModel) architecture pattern with GetX.

## Layers

### Model

Responsible for representing data objects.

Examples:

* ProductModel
* RatingModel

---

### View

Responsible for rendering UI.

Examples:

* HomeView
* ProductDetailsView
* FavoritesView

Views do not contain business logic.

---

### ViewModel (GetX Controller)

Responsible for:

* Managing UI state
* Handling user interactions
* Communicating with repositories

Examples:

* HomeController
* FavoritesController

---

### Repository

Responsible for:

* Fetching data from API
* Returning parsed models to controllers

Example:

* ProductRepository

---

### Service Layer

Responsible for application-wide services and local persistence.

Example:

* FavoriteService

FavoriteService handles:

* Favorite product IDs
* Local storage using SharedPreferences
* Favorite state restoration after app restart

---

# Data Flow

```text
UI (View)
    ↓
Controller (ViewModel)
    ↓
Repository
    ↓
API / Local Storage
```

---

# State Management Explanation

This project uses GetX for state management.

## Why GetX?

* Lightweight
* High performance
* Simple dependency injection
* Reactive programming support
* Route management support

---

## Reactive State

Reactive variables are implemented using Rx types.

Example:

```dart
final products = <ProductModel>[].obs;
final screenState = ScreenState.loading.obs;
```

UI updates automatically when values change.

Example:

```dart
Obx(() {
  return Text(
    controller.products.length.toString(),
  );
})
```

---

## Dependency Injection

Dependencies are registered using GetX bindings.

Example:

```dart
Get.lazyPut<ProductRepository>(
  () => ProductRepository(
    dio: Get.find(),
  ),
);
```

Global dependencies are registered inside:

```text
InitialBinding
```

Feature-specific controllers are registered inside their respective module bindings.

---

# Loading, Error and Empty State Handling

The application uses a dedicated ScreenState enum.

```dart
enum ScreenState {
  initial,
  loading,
  success,
  empty,
  error,
}
```

Supported states:

* Loading State
* Success State
* Empty State
* Error State

This ensures only one screen state is active at a time.

---

# Favorites Implementation

Favorites are stored locally using SharedPreferences.

Only product IDs are stored.

Example:

```json
[
  1,
  4,
  8,
  12
]
```

Benefits:

* Faster access
* Less storage usage
* Easier synchronization

Favorite products remain available after restarting the application.

---

# Third-party Packages Used

## get

Purpose:

* State Management
* Dependency Injection
* Navigation

Package:

```yaml
get:
```

---

## dio

Purpose:

* REST API communication
* Network requests
* Error handling

Package:

```yaml
dio:
```

---

## shared_preferences

Purpose:

* Local data persistence
* Storing favorite product IDs

Package:

```yaml
shared_preferences:
```

---

## cached_network_image

Purpose:

* Efficient image loading
* Image caching
* Placeholder support

Package:

```yaml
cached_network_image:
```

---

# Assumptions

* Internet connection is available for fetching products.
* Favorite products are identified using unique product IDs.
* Search functionality is performed locally after product data is loaded.

---

# Future Improvements

* Pagination
* Pull-to-refresh
* Product sorting
* Product filtering
* Dark mode support
* Unit testing
* Integration testing
* Hive database support
* Offline product caching

---

# Author

Flutter Developer Assignment Submission

Built with Flutter, GetX, MVVM, Dio, and SharedPreferences.

