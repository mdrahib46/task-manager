# 📝 Task Manager App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Provider](https://img.shields.io/badge/State_Management-Provider-blue?style=for-the-badge)](https://pub.dev/packages/provider)

A production-grade, feature-rich Task Management application built with **Flutter** and **Provider** state management. The app interfaces with a backend RESTful API to enable user authentication, account recovery workflows, real-time task lifecycle tracking, status management, and profile customization.

---

## 📸 Overview & Screenshots

| Login Screen | Dashboard / New Tasks | Task Statuses | Update Profile |
| :---: | :---: | :---: | :---: |
| *(Add Screenshot)* | *(Add Screenshot)* | *(Add Screenshot)* | *(Add Screenshot)* |

---

## ✨ Features

### 🔐 Authentication & Security
- **JWT-Based Login & Sign-Up:** Secure user authentication with token-based authorization headers.
- **Persistent Sessions:** Saves user details and access tokens locally using `SharedPreferences`.
- **Auto-Login:** Automatically navigates authenticated users directly to the main screen via `SplashScreen`.
- **Logout:** Securely wipes local user credentials upon logging out.

### 🔑 Password Recovery System
- **Email Verification:** Validates user account email.
- **PIN/OTP Verification:** Interactive 6-digit OTP verification powered by `pin_code_fields`.
- **Reset Password:** Interface to update credentials securely following successful verification.

### 📋 Task Management
- **Status Dashboard:** Visual summary cards displaying real-time counts for tasks by status (*New*, *Progress*, *Completed*, *Canceled*).
- **Categorized Views:** Filter tasks across dedicated navigation tabs.
- **Status Update Workflow:** Switch task status on the fly (e.g., move tasks from *New* to *In Progress* or *Completed*).
- **Create New Task:** Add tasks with title and detailed descriptions.
- **Delete Task:** Remove tasks with optimistic local list updates and updated status counters.

### 👤 Profile Customization
- **User Info Updates:** Edit First Name, Last Name, Mobile Number, and Password.
- **Profile Avatar:** Choose profile pictures from device gallery using `image_picker` with base64 image encoding support.

---

## 🛠️ Tech Stack & Dependencies

| Category | Technology / Package | Purpose |
| --- | --- | --- |
| **Framework** | [Flutter](https://flutter.dev) | Cross-platform mobile development |
| **State Management** | [`provider`](https://pub.dev/packages/provider) `^6.1.5` | Reactive state management & dependency injection |
| **Networking** | [`http`](https://pub.dev/packages/http) `^1.6.0` | Handling REST API requests & HTTP responses |
| **Local Storage** | [`shared_preferences`](https://pub.dev/packages/shared_preferences) `^2.5.4` | Local caching of tokens and user model JSON |
| **UI Utilities** | [`flutter_svg`](https://pub.dev/packages/flutter_svg) `^2.2.3` | Scalable Vector Graphics background and logo rendering |
| **Input & OTP** | [`pin_code_fields`](https://pub.dev/packages/pin_code_fields) `^9.1.0` | 6-digit pin code input for OTP verification |
| **Media Handling** | [`image_picker`](https://pub.dev/packages/image_picker) `^1.2.1` | Gallery image selection for profile pictures |
| **Image Processing** | [`image`](https://pub.dev/packages/image) `^4.8.0` | Image decoding and resizing utilities |
| **Logging** | [`logger`](https://pub.dev/packages/logger) `^2.6.2` | Console logging for requests and exceptions |

---

## 📁 Project Architecture & Folder Structure

The project follows a clean, maintainable layered structure separating data, controllers, providers, UI screens, and reusable widgets:

```
lib/
├── app.dart                   # MaterialApp config & route generation
├── main.dart                  # Entry point with MultiProvider setup
│
├── controller/                # Authentication & Storage Controller
│   ├── auth_controller.dart   # SharedPreferences persistence layer
│   └── test_auth_controller.dart
│
├── data/                      # Data Layer
│   ├── models/                # Data Transfer Objects & Response Models
│   │   ├── network_response.dart
│   │   ├── task_count_status_model.dart
│   │   ├── task_model.dart
│   │   └── user_model.dart
│   └── services/              # REST Client Wrapper
│       └── api_caller.dart    # Centralized HTTP request handling
│
├── provider/                  # State Management Layer (ChangeNotifiers)
│   ├── atuh_provider.dart     # Handles Login, Registration, and Auth state
│   ├── navigation_provider.dart
│   └── task_provider.dart     # Handles Task CRUD operations & status counts
│
├── screens/                   # App Views / Screens
│   ├── splash_screen.dart
│   ├── signin_screen.dart
│   ├── signup_screen.dart
│   ├── email_verify_screen.dart
│   ├── pin_verify_screen.dart
│   ├── set_password_screen.dart
│   ├── main_bottom_nav_screen.dart
│   ├── new_task_screen.dart
│   ├── inProgress_task_screen.dart
│   ├── completed_task_screen.dart
│   ├── canceled_task_screen.dart
│   ├── create_new_task_screen.dart
│   └── update_profile_screen.dart
│
├── utils/                     # Constants, URLs & Theming
│   ├── app_urls.dart          # Centralized API endpoint configurations
│   ├── asset_path.dart        # Image asset constants
│   └── themes/
│       └── light_theme.dart   # Global light theme styling
│
└── widgets/                   # Reusable UI Components
    ├── TMAppBar.dart          # Custom Top App Bar with User Profile Tile
    ├── custom_app_background.dart # SVG Background overlay
    ├── task_card_tile.dart    # Card widget for individual task display
    ├── task_summary_card.dart # Dashboard status count card
    ├── snackbar_message.dart  # Standardized snackbar notifications
    ├── heading_text_section.dart
    └── auth_prompt_text_button.dart
```

---

## 🔗 REST API Endpoints

All network interactions communicate with the base URL: `https://task-manager-api.ostad.live/api/v1`

| Endpoint | Method | Headers | Description |
|---|---|---|---|
| `/Registration` | `POST` | `Content-Type: application/json` | Register a new user |
| `/Login` | `POST` | `Content-Type: application/json` | Authenticate user & receive JWT token |
| `/ProfileUpdate` | `POST` | `token: <JWT>` | Update user profile data & photo |
| `/RecoverVerifyEmail/{email}` | `GET` | — | Initiate account recovery for given email |
| `/RecoverVerifyOtp/{email}/{otp}` | `GET` | — | Verify 6-digit OTP code |
| `/RecoverResetPassword` | `POST` | `Content-Type: application/json` | Submit new password |
| `/createTask` | `POST` | `token: <JWT>` | Create a new task item |
| `/listTaskByStatus/{status}` | `GET` | `token: <JWT>` | Retrieve tasks by status (`New`, `Progress`, `Completed`, `Canceled`) |
| `/updateTaskStatus/{id}/{status}` | `GET` | `token: <JWT>` | Update status of a specific task |
| `/deleteTask/{id}` | `GET` | `token: <JWT>` | Delete a task by ID |
| `/taskStatusCount` | `GET` | `token: <JWT>` | Get aggregated task counts by status |

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.10.4`)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE such as **Android Studio** or **VS Code** with Flutter extensions
- Android Emulator / iOS Simulator / Physical Device

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/taskmanagerapp.git
   cd taskmanagerapp
   ```

2. **Fetch dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter environment:**
   ```bash
   flutter doctor
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 🤝 Contributing

Contributions are welcome! Follow these steps to contribute:
1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/NewFeature`).
3. Commit your Changes (`git commit -m 'Add some NewFeature'`).
4. Push to the Branch (`git push origin feature/NewFeature`).
5. Open a Pull Request.

---

## 📜 License

Distributed under the [MIT License](LICENSE). See `LICENSE` for more information.
