# Managing Images for CarePlan Library App

This directory (`assets/images/`) is intended to store all static image assets used within the CarePlan Library application. This includes images for individual care plans, category icons, or any other visual elements.

## Purpose

*   **Care Plan Images**: Illustrative images that can be displayed on the `CarePlanDetailScreen` or `CarePlanCard` to visually represent a care plan topic.
*   **Category Icons/Images**: Visual cues for different care plan categories displayed on the `HomeScreen` or `CarePlanListScreen`.
*   **Other UI Assets**: Any other static images required for the app's UI.

## Adding Images

### 1. Adding Images for Care Plans

Individual care plans can have an associated image displayed on their detail screen or card.

*   **Naming Convention**: Use clear, descriptive names for your image files (e.g., `heart_anatomy.png`, `respiratory_assessment.jpg`).
*   **Supported Formats**: Standard image formats like PNG, JPG, JPEG, GIF are supported. PNG is often preferred for images requiring transparency.
*   **Placement**: Place the image file directly into this `assets/images/` directory or a relevant subdirectory (e.g., `assets/images/cardiovascular/`).
*   **Updating `care_plans.json`**:
    *   After adding the image to this folder, you need to reference it in the `assets/data/care_plans.json` file.
    *   Find the specific care plan object in the JSON file.
    *   Update its `imageUrl` field with the relative path to the image from the `assets` directory.
        *   Example: `"imageUrl": "assets/images/heart_failure_illustration.png"`
        *   Example (if in a subdirectory): `"imageUrl": "assets/images/cardiovascular/heart_anatomy.png"`
*   **`pubspec.yaml`**: Ensure that the `assets/images/` path (or any new subdirectories you create under it) is declared in your `pubspec.yaml` file under the `flutter:` -> `assets:` section so Flutter can access them.
    ```yaml
    flutter:
      assets:
        - assets/images/
        # If you add subdirectories, you might list them explicitly or ensure the main path covers them.
        # - assets/images/cardiovascular/
        # - assets/images/respiratory/
    ```
    After updating `pubspec.yaml`, you might need to stop and restart your Flutter application.

### 2. Adding Icons/Images for Categories

Categories can be visually represented by icons (using Flutter's built-in `Icons` or custom font icons) or small images. The current implementation in `HomeScreen` (`_getIconForCategory` method) primarily uses `IconData`.

*   **If using `IconData` (Recommended for consistency & scalability)**:
    *   No image files are needed here. You would map category names to `IconData` directly in the code (as seen in `home_screen.dart`).
*   **If you want to use image files for categories**:
    1.  **Naming**: `cardiovascular_category_icon.png`, `respiratory_category_icon.svg`.
    2.  **Placement**: Place them in `assets/images/categories/` (create this subdirectory if it doesn't exist).
    3.  **`pubspec.yaml`**: Add `assets/images/categories/` to your `pubspec.yaml`.
    4.  **Code Update**: Modify the `_getIconForCategory` method in `HomeScreen` (or similar logic where category icons are displayed) to load these images using `Image.asset('assets/images/categories/your_icon.png')` instead of returning an `IconData`. You might need to adjust widget layouts to accommodate images instead of icons.

## General Guidelines

*   **Optimize Images**: Compress images to reduce their file size without significant loss of quality. This helps keep the app size smaller and improves loading performance. Tools like TinyPNG or ImageOptim can be used.
*   **Resolution**: Provide images at appropriate resolutions. Consider using resolution-aware asset variants (e.g., `1.0x`, `2.0x`, `3.0x` subfolders) if targeting multiple device pixel densities with high precision, though for many illustrative images, a single well-sized asset might suffice.
*   **Consistency**: Try to maintain a consistent style and aspect ratio for images used in similar contexts (e.g., all care plan header images).

By following these guidelines, you can effectively manage and integrate visual assets into the CarePlan Library app.
