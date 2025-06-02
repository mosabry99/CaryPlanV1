# CarePlan Library - Flutter App

**A Digital Guide of Pre-Written Nursing Care Plans**

The CarePlan Library is a professionally designed Flutter application that provides a curated, searchable library of evidence-based nursing care plans. It serves as a read-only reference tool, ideal for nursing students, educators, and clinical nurses. The app is built with modern UI/UX standards, a scalable architecture, and is designed to be easily customizable and resale-ready.

## Table of Contents

1.  [Features](#features)
2.  [Architecture Overview](#architecture-overview)
3.  [Folder Structure](#folder-structure)
4.  [Getting Started](#getting-started)
    *   [Prerequisites](#prerequisites)
    *   [Installation](#installation)
    *   [Running the App](#running-the-app)
    *   [Building for Release](#building-for-release)
5.  [Data Management](#data-management)
    *   [Local Data Source](#local-data-source)
    *   [Adding/Editing Care Plans](#addingediting-care-plans)
6.  [Customization Guide](#customization-guide)
    *   [Theming](#theming)
    *   [Responsive Design](#responsive-design)
    *   [Adding New Screens](#adding-new-screens)
    *   [Modifying Care Plan Data Structure](#modifying-care-plan-data-structure)
    *   [Optional Firebase Integration](#optional-firebase-integration)
7.  [Testing & Linting](#testing--linting)
8.  [Resale Information](#resale-information)
9.  [Key Dependencies](#key-dependencies)
10. [Future Enhancements](#future-enhancements)
11. [License](#license)
12. [Contact/Support](#contactsupport)

## Features

*   **Modern & Sleek UI/UX**: Polished interface with responsive layouts for various screen sizes.
*   **Light/Dark Mode**: System-based theme adaptation.
*   **Comprehensive Care Plan Display**:
    *   **HomeScreen**: Features search functionality, category browsing, and featured care plans.
    *   **CarePlanListScreen**: Displays care plans by category with filter chips and sorting options.
    *   **CarePlanDetailScreen**: Provides a detailed view of each care plan, including assessments, diagnoses, goals, interventions, evaluations, and references.
*   **Favorites**: Users can mark care plans as favorites for quick access.
    *   **FavoritesScreen**: Lists all locally saved favorite care plans.
*   **Settings**:
    *   **SettingsScreen**: Allows users to toggle theme mode, adjust font size, and view app information.
    *   Data management options like clearing favorites and search history.
*   **Offline Access**: Care plan data is stored locally in JSON, ensuring full offline functionality.
*   **Search & Filtering**: Robust search across titles, descriptions, and tags. Filter by category and tags.
*   **Responsive Design**: Adapts to different screen sizes and orientations using `flutter_screenutil`.
*   **Scalable Architecture**: Built with clean architecture principles for maintainability and future growth.
*   **Resale-Ready**: Well-documented, structured, and easily customizable code.

## Architecture Overview

The application follows a clean architecture pattern, promoting separation of concerns and making the codebase modular, testable, and scalable.

*   **Presentation Layer (UI)**:
    *   Built with Flutter widgets.
    *   Screens are organized within the `features` directory.
    *   Shared UI components are located in `lib/shared/widgets/`.
    *   Uses `flutter_hooks` for managing widget state efficiently.
*   **State Management**:
    *   `hooks_riverpod` is used for state management, providing a reactive and declarative way to manage application state. Providers are used to expose repositories, application state (like theme, font size), and filtered data.
*   **Navigation**:
    *   `go_router` is used for declarative routing, enabling named routes, path parameters, and query parameters. Route configuration is centralized in `lib/core/router/app_router.dart`.
*   **Data Layer**:
    *   **Models**: Data models (e.g., `CarePlanModel`, `SectionModel`) are defined using `freezed` for immutable data classes and JSON serialization/deserialization.
    *   **Repositories**: The `CarePlanRepository` (`lib/repositories/care_plan_repository.dart`) handles data operations, abstracting the data source (local JSON) from the UI. It's responsible for loading, parsing, searching, and filtering care plans.
    *   **Local Storage**: `shared_preferences` (via `LocalStorageService` in `lib/core/services/`) is used for persisting user preferences like favorites, theme mode, and font size.
*   **Entry Point**:
    *   `main.dart` is minimal, delegating app initialization to `bootstrap.dart`.
    *   `bootstrap.dart` handles setting up services (like `LocalStorageService`), error handling, and running the main application widget.
*   **Theming**:
    *   Centralized theming in `lib/theme/app_theme.dart` using `ColorScheme.fromSeed` for Material 3 compliance and `GoogleFonts` for typography.
    *   Supports light and dark modes based on system settings or user preference.
*   **Responsive Design**:
    *   `flutter_screenutil` is used to adapt UI layout and font sizes to different screen dimensions.

## Folder Structure

The project follows a feature-first approach for organizing code, with a core directory for shared utilities and configurations.

```
/care_plan_library
├── android
├── assets
│   ├── data/
│   │   └── care_plans.json  # Main data source for care plans
│   └── images/              # Placeholder for care plan related images (e.g., category icons)
│   └── icons/               # Placeholder for app icons
├── ios
├── lib
│   ├── core                 # Core utilities, constants, services, and router
│   │   ├── router/
│   │   │   └── app_router.dart
│   │   └── services/
│   │       └── local_storage_service.dart
│   ├── features             # Feature-specific modules
│   │   ├── care_plan/
│   │   │   ├── screens/
│   │   │   │   ├── care_plan_detail_screen.dart
│   │   │   │   └── care_plan_list_screen.dart
│   │   │   ├── widgets/     # Widgets specific to care_plan feature
│   │   │   └── controllers/ # State management logic (Riverpod providers) for care_plan
│   │   ├── favorites/
│   │   │   └── screens/
│   │   │       └── favorites_screen.dart
│   │   ├── home/
│   │   │   └── screens/
│   │   │       └── home_screen.dart
│   │   └── settings/
│   │       └── screens/
│   │           └── settings_screen.dart
│   ├── models               # Data models (using freezed)
│   │   └── care_plan_model.dart
│   ├── repositories         # Data abstraction layer
│   │   └── care_plan_repository.dart
│   ├── services             # Optional Firebase wrappers (not implemented by default)
│   ├── shared               # Shared widgets and utilities across features
│   │   └── widgets/
│   │       ├── care_plan_card.dart
│   │       └── custom_search_bar.dart
│   ├── theme                # Theming configuration
│   │   └── app_theme.dart
│   ├── utils                # Helper functions, formatters, extensions (placeholder)
│   ├── bootstrap.dart       # App initialization logic
│   └── main.dart            # Main entry point of the application
├── test                     # Unit and widget tests
└── pubspec.yaml             # Project dependencies and metadata
```

## Getting Started

Follow these instructions to set up and run the CarePlan Library app on your local machine.

### Prerequisites

*   **Flutter SDK**: Ensure you have Flutter installed. If not, follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).
    *   Recommended Flutter version: 3.19.x or later.
    *   Dart SDK: 3.x.x or later.
*   **IDE**: Android Studio, IntelliJ IDEA with Flutter plugin, or VS Code with Flutter extension.
*   **Emulator/Device**: An Android emulator, iOS simulator, or a physical device connected for testing.

### Installation

1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/mosabry99/CaryPlanV1.git # Or your repository URL
    cd CaryPlanV1/care_plan_library # Navigate into the Flutter project directory
    ```

2.  **Install Dependencies**:
    Run the following command in your terminal from the `care_plan_library` project root:
    ```bash
    flutter pub get
    ```
    This will download all the necessary packages defined in `pubspec.yaml`.

3.  **Generate Code (for `freezed` models)**:
    If you modify any of the `freezed` models (e.g., `care_plan_model.dart`), you'll need to run the code generator:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running the App

1.  **Select a Device**: Ensure an emulator is running or a physical device is connected and recognized by Flutter (`flutter devices`).
2.  **Run the App**:
    Execute the following command from the `care_plan_library` project root:
    ```bash
    flutter run
    ```
    This will build and run the app on the selected device/emulator.

### Building for Release

To build a release version of the app:

*   **Android**:
    ```bash
    flutter build apk --release
    # or for app bundle
    flutter build appbundle --release
    ```
    The output will be in `build/app/outputs/flutter-apk/` or `build/app/outputs/bundle/release/`.

*   **iOS**:
    ```bash
    flutter build ios --release
    ```
    This requires Xcode and an Apple Developer account for distribution. The output can be found in `build/ios/archive/`.

## Data Management

### Local Data Source

The primary data for nursing care plans is stored locally within the app in a JSON file:
`assets/data/care_plans.json`

This file contains an array of care plan objects, each adhering to the structure defined in `lib/models/care_plan_model.dart`. This approach allows the app to function fully offline.

### Adding/Editing Care Plans

To add new care plans or modify existing ones:

1.  **Locate the JSON File**: Open `assets/data/care_plans.json`.
2.  **Understand the Structure**: Each care plan object has fields like `id`, `title`, `category`, `tags`, `description`, `assessments`, `nursingDiagnoses`, `goals`, `interventions`, `evaluations`, `references`, `isFeatured`, `lastUpdated`, etc. Refer to `CarePlanModel` for the exact structure.
    *   **ID**: Ensure each `id` is unique.
    *   **Dates**: `lastUpdated` should be in ISO 8601 format (e.g., `"2023-10-15T08:00:00Z"`).
    *   **Images**: `imageUrl` can point to local assets (e.g., `"assets/images/heart.png"`) or a remote URL. If using local assets, ensure they are added to the `assets/images/` folder and declared in `pubspec.yaml`.
3.  **Add or Modify Data**:
    *   To add a new care plan, copy an existing object, paste it as a new element in the JSON array, and modify its content. Ensure correct JSON syntax (commas between objects, correct brackets).
    *   To edit, find the relevant care plan object by its `id` or `title` and change the desired fields.
4.  **Validate JSON**: After editing, it's recommended to validate the JSON structure using an online validator or an IDE feature to ensure it's well-formed.
5.  **Rebuild the App**: After saving changes to the JSON file, a hot restart or full rebuild of the app (`flutter run`) will usually be needed for the changes to take effect, as asset files are bundled at build time.

The `CarePlanRepository` handles loading and parsing this JSON data.

## Customization Guide

### Theming

The app's visual appearance is managed through a centralized theme system.

*   **Theme Files**:
    *   `lib/theme/app_theme.dart`: Defines `AppTheme.lightTheme` and `AppTheme.darkTheme`.
*   **Changing Colors**:
    *   Modify the seed colors (`_lightPrimarySeed`, `_darkPrimarySeed`, etc.) in `app_theme.dart`. `ColorScheme.fromSeed` will generate a full Material 3 color palette based on these.
    *   You can also override specific `ColorScheme` colors directly if needed.
*   **Changing Fonts**:
    *   The app uses `GoogleFonts.interTextTheme()` by default. To change the font, update this in the `_buildTextTheme` method in `app_theme.dart`.
    *   Ensure the new font is added to `pubspec.yaml` if it's a custom font.
*   **Component Styles**:
    *   Specific widget themes (AppBar, Card, Button, etc.) are customized within `_buildTheme` in `app_theme.dart`.

### Responsive Design

*   `flutter_screenutil` is initialized in `bootstrap.dart` with a design size (e.g., `Size(375, 812)`).
*   Use `.w`, `.h`, and `.sp` extensions for sizing and font sizes to make them responsive (e.g., `16.w`, `24.h`, `14.sp`).

### Adding New Screens

1.  **Create Screen File**: Add your new screen widget in the appropriate feature directory (e.g., `lib/features/new_feature/screens/new_screen.dart`).
2.  **Define Route**: Add a new route definition in `lib/core/router/app_router.dart`.
    *   Define a path and name for the route in `AppRoutes`.
    *   Add a `GoRoute` entry in the `appRouter` configuration.
3.  **Navigate**: Use `context.push('/new-route-path')` or `context.goNamed('newRouteName')` to navigate to the new screen.

### Modifying Care Plan Data Structure

If you need to add new fields to the care plans:

1.  **Update Model**: Modify `lib/models/care_plan_model.dart` (and any relevant sub-models like `AssessmentSection`). Add the new fields to the `freezed` class definition.
2.  **Regenerate Code**: Run `flutter pub run build_runner build --delete-conflicting-outputs` to update the `.freezed.dart` and `.g.dart` files.
3.  **Update JSON Data**: Add the new fields with corresponding data to your `assets/data/care_plans.json` for each care plan.
4.  **Update UI**: Modify the relevant screens and widgets (e.g., `CarePlanDetailScreen`, `CarePlanCard`) to display the new data.

### Optional Firebase Integration

The app is structured to easily accommodate Firebase for features like:

*   **Authentication**: For user accounts, personalized favorites, or premium content.
*   **Cloud Firestore**: To store care plans in the cloud, allowing for remote updates and user-generated content (if desired).
*   **Firebase Storage**: For hosting images or other assets.
*   **Remote Config**: For A/B testing or dynamic app configuration.

**Steps to Integrate Firebase (General Guide)**:

1.  **Add Dependencies**: Uncomment Firebase dependencies in `pubspec.yaml` (`firebase_core`, `firebase_auth`, `cloud_firestore`, etc.).
2.  **Firebase Project Setup**: Create a Firebase project and register your Flutter app (Android, iOS). Follow the Firebase console instructions to add configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS).
3.  **Initialize Firebase**: Call `await Firebase.initializeApp()` in `_initializeServices()` within `lib/bootstrap.dart`.
4.  **Service Wrappers**: Create service classes in `lib/services/firebase/` to encapsulate Firebase logic (e.g., `AuthService`, `FirestoreService`).
5.  **Repository Updates**: Modify `CarePlanRepository` (or create new repositories) to interact with Firebase services instead of/in addition to local JSON.
    *   For example, `getAllCarePlans()` could fetch from Firestore.
    *   Favorites could be stored per user in Firestore.
6.  **UI Integration**: Update UI elements and providers to use the new Firebase-backed data and authentication state.
7.  **Environment Configuration**: Use `.env` or `flutter_dotenv` for secure Firebase configuration if needed (though Firebase config files are usually sufficient for client-side).

## Testing & Linting

*   **Linting**: The project is set up with `flutter_lints` and `very_good_analysis` for strict linting rules, promoting code quality and consistency. Run `flutter analyze` to check for linting issues.
*   **Unit Tests**:
    *   Focus unit tests on model parsing (`fromJson` methods) to ensure data integrity from the JSON source.
    *   Test logic within repositories (e.g., filtering logic, search functionality).
    *   Test state management logic within Riverpod providers/controllers.
    *   Example: `test/models/care_plan_model_test.dart` could verify `CarePlanModel.fromJson`.
*   **Widget Tests**:
    *   Test individual widgets and screen components to ensure they render correctly and respond to user interactions.
*   **Integration Tests**:
    *   Consider integration tests for critical user flows, such as navigating through screens, searching, and favoriting.

## Resale Information

This CarePlan Library app is designed with resale in mind, offering several advantages:

*   **Production-Ready Code**: The codebase is structured, clean, and follows modern Flutter best practices.
*   **Scalable Architecture**: Clean architecture and Riverpod make it easy to extend the app with new features or integrate backend services like Firebase.
*   **Comprehensive Documentation**: This README provides detailed information for setup, customization, and understanding the app's structure.
*   **Easy Customization**:
    *   **Theming**: Easily rebrand the app by changing colors and fonts.
    *   **Data**: The care plan content can be entirely replaced or expanded by modifying the `care_plans.json` file.
    *   **Localization**: (Not implemented by default but can be added) Structure supports adding localization for different languages.
*   **Offline First**: Core functionality works offline, which is a strong selling point for a reference app.
*   **Modern UI/UX**: A polished and intuitive user interface enhances user satisfaction.
*   **No Backend Dependency (by default)**: Reduces operational complexity and costs for the initial version. Firebase can be added modularly if required.

**To prepare for resale, consider**:

1.  **Branding**: Update app name, icons, splash screen, and theme colors.
2.  **Content**: Replace or expand the `care_plans.json` data with your proprietary content.
3.  **Legal**: Add your own Privacy Policy and Terms of Service (links can be added in `SettingsScreen`).
4.  **Firebase (Optional)**: If adding Firebase, ensure proper project setup and security rules.
5.  **App Store Listings**: Prepare compelling descriptions, screenshots, and keywords for app store submission.

## Key Dependencies

*   `flutter_hooks` & `hooks_riverpod`: For state management.
*   `go_router`: For navigation.
*   `freezed` & `json_serializable`: For data models and code generation.
*   `flutter_screenutil`: For responsive UI design.
*   `google_fonts`: For typography.
*   `shared_preferences`: For local data persistence (favorites, settings).
*   `shimmer`: For loading animations.
*   `intl`: For date formatting.

(Refer to `pubspec.yaml` for a full list and versions.)

## Future Enhancements

*   **User Accounts & Cloud Sync**: Firebase integration for user authentication and syncing favorites across devices.
*   **Premium Content**: Offer additional care plans or features via in-app purchases.
*   **User-Generated Notes**: Allow users to add personal notes to care plans.
*   **Advanced Search Filters**: More granular filtering options (e.g., by specific assessment findings).
*   **Offline Full-Text Search**: Implement a more robust local search solution if performance with JSON parsing becomes an issue for very large datasets (e.g., using SQLite with FTS5).
*   **Push Notifications**: For new content updates or reminders.
*   **Localization**: Support for multiple languages.
*   **Accessibility Improvements**: Further enhancements for WCAG compliance.
*   **Interactive Elements**: Quizzes or case studies based on care plans.

## License

Consider adding a license file (e.g., MIT, Apache 2.0) if you plan to distribute the source code or make it open source. For resale, you will likely define licensing terms in your sales agreement.

## Contact/Support

For inquiries regarding customization, resale, or support for this application template, please contact:

[Your Name/Company Name]
[Your Email Address or Website]

---

This README provides a comprehensive guide to the CarePlan Library Flutter application.
