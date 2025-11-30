# Project Architecture & Implementation Guide

## 1. Architecture Overview

This project follows **Clean Architecture** principles to ensure separation of concerns, testability, and scalability. The code is organized into three main layers:

### **Presentation Layer** (`lib/features/auth/presentation`)
- **Responsibility**: Handles UI and State Management.
- **Components**:
    - **Pages**: `LoginPage`, `SignupPage` (UI widgets).
    - **Controllers**: `AuthController` (Riverpod `AsyncNotifier` for managing state).
- **Interaction**: Observes state changes and triggers UseCases. **Never** accesses the Data Layer directly.

### **Domain Layer** (`lib/features/auth/domain`)
- **Responsibility**: Contains the business logic and entities. Independent of external frameworks (UI, Database, Network).
- **Components**:
    - **Entities**: `AuthEntity`, `UserEntity` (Pure Dart classes/Freezed models).
    - **Repositories (Interfaces)**: `AuthRepository` (Abstract contract for data operations).
    - **UseCases**: `LoginUseCase`, `SignupUseCase`, etc. (Single responsibility classes encapsulating specific business rules).
- **Interaction**: Called by the Presentation Layer; implemented by the Data Layer.

### **Data Layer** (`lib/features/auth/data`)
- **Responsibility**: Handles data retrieval and storage.
- **Components**:
    - **DataSources**: `AuthRemoteDataSource` (API calls via Dio).
    - **Repositories (Implementation)**: `AuthRepositoryImpl` (Implements Domain interfaces, coordinates DataSources and Local Storage).
    - **DTOs**: Data Transfer Objects (often shared with Entities in simple apps, or separate models).
- **Interaction**: Implements Domain repositories; talks to external worlds (API, DB).

---

## 2. Login & Signup Implementation Flow

The authentication flow demonstrates the unidirectional data flow:

1.  **UI Event**: User clicks "Login" in `LoginPage`.
2.  **Controller**: `AuthController.login()` is called. It sets state to `loading`.
3.  **UseCase**: `AuthController` calls `LoginUseCase(email, password)`.
4.  **Repository**: `LoginUseCase` calls `AuthRepository.login()`.
5.  **Implementation**: `AuthRepositoryImpl` calls `AuthRemoteDataSource.login()`.
6.  **Network**: `AuthRemoteDataSource` makes a POST request to `/auth/login` using `Dio`.
7.  **Response**: API returns a token.
8.  **Storage**: `AuthRepositoryImpl` saves the token using `TokenStorage` (FlutterSecureStorage).
9.  **State Update**: `AuthController` receives the success result and updates state to `AsyncData`.
10. **Navigation**: `LoginPage` listens to the state change and redirects to `/` (Home) via `GoRouter`.

---

## 3. Key Packages & Purpose

| Package | Purpose | Why we chose it |
| :--- | :--- | :--- |
| **flutter_riverpod** | State Management | Compile-time safety, easy testing, and no `BuildContext` dependency for logic. |
| **riverpod_annotation** | Code Generation | Reduces boilerplate for Riverpod providers. |
| **go_router** | Navigation | Declarative routing, deep linking support, and easy redirection logic (Guards). |
| **dio** | Networking | Powerful HTTP client with interceptors (used for injecting Auth tokens). |
| **flutter_secure_storage** | Local Storage | Securely stores sensitive data like Access and Refresh tokens (Keychain/Keystore). |
| **freezed** | Data Classes | Generates immutable classes, `copyWith`, `toString`, and equality comparisons. |
| **json_serializable** | JSON Parsing | Generates `fromJson`/`toJson` methods automatically. |
| **google_sign_in** | Social Auth | Native Google Sign-In integration. |
| **sign_in_with_apple** | Social Auth | Native Apple Sign-In integration. |
| **build_runner** | Tooling | Runs code generators (Freezed, Riverpod, JSON Serializable). |

---

## 4. Core Infrastructure

- **`core/network/dio_client.dart`**: Configures Dio with a base URL and an **Interceptor**. The interceptor automatically adds the `Authorization: Bearer <token>` header to every request if a token exists in storage.
- **`core/storage/token_storage.dart`**: A wrapper around `FlutterSecureStorage` to handle reading, writing, and deleting tokens safely.
- **`core/router/app_router.dart`**: Defines the app's navigation tree. It includes a **redirect** function that acts as a "Guard":
    - If user is **not** logged in -> Redirect to `/login`.
    - If user **is** logged in and tries to access Login/Signup -> Redirect to `/` (Home).
