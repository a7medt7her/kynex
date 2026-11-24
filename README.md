<img src="assets/banner.svg" alt="kynex" width="100%">

A Flutter app with Firebase authentication and a step-by-step profile setup for fitness.

## Features
- Splash and onboarding screens
- Register and login with Firebase Authentication
- Setup flow: gender, body measurements, fitness goal (muscle gain, weight loss, flexibility, endurance), activity level and exercise information, with a progress indicator
- Unit switching between kg/lb and cm/ft
- User data saved to Cloud Firestore

## Status
In progress. The home screen is still a placeholder.

## Tech stack
Flutter, Dart, flutter_bloc (Cubit), Firebase Auth, Cloud Firestore, Dio, Dartz, get_it, flutter_secure_storage, flutter_screenutil, toastification

## Run it
Connect your own Firebase project (`flutterfire configure`), then:
```
flutter pub get
flutter run
```
