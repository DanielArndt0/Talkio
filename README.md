
# 📱 Talkio

**Talkio** is a real-time messaging app built with Flutter and Firebase. It supports private chats between users, auto-generated avatars, typing indicators, and a modern user experience.

## 🚀 Features

- 🔐 Firebase Authentication  
- 💬 Private 1-to-1 chat system  
- 👤 Auto-generated avatars based on user UID  
- ✍️ Typing status indication in real time  
- 📩 Real-time message updates with Firestore  
- 🔎 Search bar to filter messges  
- 📱 Responsive and modern chat UI

## 📱 Screenshots

<p align="center">
  <img src="images/Screenshots/screenshot(1).png" width="150" />
  <img src="images/Screenshots/screenshot(2).png" width="150" />
  <img src="images/Screenshots/screenshot(4).png" width="150" />
  <img src="images/Screenshots/screenshot(5).png" width="150" />
  <img src="images/Screenshots/screenshot(6).png" width="150" />
</p>

## 📦 Installation
```bash
git clone https://github.com/your-username/talkio.git
cd talkio
flutter pub get
flutter run --dart-define-from-file=env/env.prd.json
```
⚠️ Make sure to include your Firebase **google-services.json** in **android/app/**
and your environment config in **env/env.prd.json.**

## 🧪 Build
```bash
flutter build apk --release --dart-define-from-file=env/env.prd.json
```

## 🛠 Technologies

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/) (Auth, Firestore)
- [Provider](https://pub.dev/packages/provider) (State Management)
- [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
- [Firebase CLI](https://firebase.google.com/docs/cli)

## 📂 Project Structure
```bash
lib/
├── app/             # App configuration and main setup
├── components/      # Reusable UI widgets
├── controllers/     # Business logic and state management
├── errors/          # Custom error classes and handlers
├── middlewares/     # Request/response interceptors or guards
├── modals/          # Modals and bottom sheets
├── models/          # Data models and entities
├── providers/       # Dependency injection and global providers
├── screens/         # UI screens and views
├── services/        # External services and APIs (e.g., Firebase)
├── utils/           # Utility functions and helpers
└── validators/      # Input validators and schemas
```

## ENV Structure
```json
{
  "androidApiKey": "androidApiKey",
  "androidAppId": "androidAppId",
  "iosApiKey": "iosApiKey",
  "iosAppId": "iosAppId",
  "iosBundleId": "iosBundleId",
  "projectId": "projectId",
  "storageBucket": "storageBucket",
  "messagingSenderId": "messagingSenderId"
}
```

## ✨ Author

Made with 💙 by [@DanielArndt0](https://github.com/DanielArndt0)
