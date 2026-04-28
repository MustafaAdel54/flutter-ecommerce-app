# E-Commerce Flutter Application

A fully functional E-Commerce application built with Flutter, designed to provide a seamless and fast shopping experience. This project showcases clean architecture, efficient state management, and modern mobile development practices.

## 🚀 Key Features

- **Product Catalog**: Fetches and displays products dynamically using REST API.
- **Authentication**: Secure user registration and login powered by Firebase Authentication.
- **Cart Management**: Add, remove, and manage cart items with real-time UI updates using BLoC State Management.
- **Interactive UI**: A modern, responsive design optimized for a smooth user experience.
- **Data Persistence**: User data, favorites, and preferences managed via Firebase Firestore.

## 🛠 Tech Stack

- **Language**: Dart
- **Framework**: Flutter
- **State Management**: BLoC (Business Logic Component)
- **Backend & Services**: Firebase (Auth, Firestore)
- **Networking**: [Http]
- **Navigation**: GoRouter

## 🏗 Project Architecture

The project follows a Feature-based Architecture to ensure clean separation of concerns and maintainability:

```plaintext
lib/
├── core/             # Shared components (Theme, Routes, Network, Extensions)
├── features/         # Individual features (Cart, Auth, Product, Profile)
│   ├── cart/         # Cart logic, BLoC, and UI
│   ├── auth/         # Authentication logic
│   └── ...
└── main.dart         # Application entry point
```

## 📱 App Previews

<p align="center">
  <img src="assets/gifs/1_commerce.gif" width="32%" />
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="assets/gifs/2_commerce.gif" width="32%" />
</p>

## 🤝 Contact

If you have any questions, suggestions, or would like to collaborate, feel free to reach out:

- **LinkedIn**: [https://www.linkedin.com/in/mustafa-eissa](https://www.linkedin.com/in/mustafa-eissa)
- **Email**: [mustafa.eissa5455@gmail.com](mailto:mustafa.eissa5455@gmail.com)