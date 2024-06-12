
# QR Code Scanner App

A Flutter application to scan QR codes and handle their content. The app uses a custom UI from ShadcnUI and includes functionalities to open URLs, copy content, and display scanned data.

## Features

- Scan QR codes using the device camera.
- Display scanned QR code content.
- Open URLs directly from the app.
- Copy scanned content to the clipboard.
- Custom UI using ShadcnUI components.

## Development Log

### Initial Setup

1. **Created a new Flutter project:**
   ```bash
   flutter create qr_code_scanner_app
   cd qr_code_scanner_app
   ```

2. **Added dependencies:**
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     shadcn_ui: ^0.5.2
     qr_code_scanner: ^1.0.0
     url_launcher: ^6.1.7
   ```

3. **Set up basic QR scanner functionality.**

### UI Integration

1. **Integrated ShadcnUI:**
   - Customized the home screen and buttons using ShadcnUI components.

### Error Handling and Debugging

1. **Camera Permission Error:**
   - Encountered an error due to missing camera permissions.
   - Solution: Added camera permissions in `AndroidManifest.xml`.

   ```xml
   <uses-permission android:name="android.permission.CAMERA"/>
   ```

2. **URL Launching Error:**
   - Faced issues with launching URLs.
   - Solution: Ensured the correct configuration for the `url_launcher` package and updated the logic to use `launchUrl`.

3. **Manifest Merger Failed:**
   - Error: `Attribute activity#io.flutter.plugins.urllauncher.WebViewActivity@theme value=(@style/Theme.AppCompat.Translucent) from (unknown) is also present at [:url_launcher_android]`
   - Solution: Used `tools:replace="android:theme"` in the `AndroidManifest.xml`.

   ```xml
   <activity 
       android:name="io.flutter.plugins.urllauncher.WebViewActivity"
       android:theme="@android:style/Theme.Translucent.NoTitleBar"
       tools:replace="android:theme"/>
   ```

4. **Missing Theme Error:**
   - Error: `resource style/Theme.AppCompat.Translucent not found`.
   - Solution: Added AppCompat dependency in `build.gradle`.

   ```gradle
   dependencies {
       implementation 'androidx.appcompat:appcompat:1.3.1'
   }
   ```

### Renaming the App

1. **Renamed the App:**
   - Changed the app name in Android and iOS configurations.
   - Used `flutter_launcher_name` package to automate renaming.

   ```yaml
   dev_dependencies:
     flutter_launcher_name: ^0.0.1
   ```

   ```yaml
   flutter_launcher_name:
     name: "New App Name"
   ```

   ```bash
   flutter pub run flutter_launcher_name:main
   ```

2. **Changed the package name:**
   - Used `change_app_package_name` package.

   ```yaml
   dev_dependencies:
     change_app_package_name: ^1.0.0
   ```

   ```bash
   flutter pub run change_app_package_name:main com.new.package.name
   ```

## How to Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/qr_code_scanner_app.git
   cd qr_code_scanner_app
   ```

2. **Get the dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Conclusion

Throughout the development of the QR Code Scanner App, several challenges were encountered and resolved, including permission issues, manifest conflicts, and the need to rename the app efficiently. By using appropriate packages and debugging tools, a functional and user-friendly application was successfully built.

### Known Issues

- Ensure all permissions are correctly granted for the camera and internet access.
- Test on multiple devices to confirm compatibility.

Feel free to contribute to this project by submitting issues or pull requests!
