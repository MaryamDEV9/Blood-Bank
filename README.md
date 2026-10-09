# BloodNet App

A blood bank network app for Egypt, supporting Arabic and English.

## Setup Instructions

1. **Clone the repository.**
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

## Firebase Configuration

This app uses Firebase. For security reasons, the Firebase configuration files are NOT included in the repository.

### Android
1. Go to the Firebase Console and create/select your project.
2. Download the `google-services.json` file.
3. Place it in `android/app/google-services.json`.

### iOS
1. Go to the Firebase Console.
2. Download the `GoogleService-Info.plist` file.
3. Place it in `ios/Runner/GoogleService-Info.plist`. (Add it via Xcode if necessary).

> Note: Both of these files are added to `.gitignore` and should never be committed to source control.

## Running the App

Run the following command to start the app on a connected device or emulator:
```bash
flutter run
```

## Security Notes
- API keys, if any, should be added via `--dart-define` or a `.env` file (also ignored by git).
- Firestore rules restrict unauthorized write access to blood bank data.
