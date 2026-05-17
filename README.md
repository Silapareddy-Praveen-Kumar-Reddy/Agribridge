# 🌾 AgriBridge — Farm-to-Consumer Mobile App

[![Flutter CI](https://github.com/silapareddy/Agribridge/actions/workflows/dart.yml/badge.svg)](https://github.com/silapareddy/Agribridge/actions)
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

A Flutter mobile shopping application connecting farmers directly to consumers. Browse fresh vegetables and lifestyle products, manage your cart, and register as a vendor — all in one app.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        AgriBridge App                           │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                    Presentation Layer                     │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌────────────┐  │   │
│  │  │ HomePage │ │ Products │ │   Cart   │ │  Checkout  │  │   │
│  │  │          │ │ + Search │ │  Screen  │ │   Screen   │  │   │
│  │  └──────────┘ └──────────┘ └──────────┘ └────────────┘  │   │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐                 │   │
│  │  │ Profile  │ │  Vendor  │ │ Contact  │                 │   │
│  │  │  Screen  │ │   Form   │ │  Screen  │                 │   │
│  │  └──────────┘ └──────────┘ └──────────┘                 │   │
│  └──────────────────────────────────────────────────────────┘   │
│                              │                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                   State Management                        │   │
│  │  ┌──────────────┐  ┌──────────────┐  ┌───────────────┐   │   │
│  │  │ CartProvider  │  │  Favorites   │  │ AuthProvider   │   │   │
│  │  │ (add/remove)  │  │   Provider   │  │ (Firebase)     │   │   │
│  │  └──────────────┘  └──────────────┘  └───────────────┘   │   │
│  └──────────────────────────────────────────────────────────┘   │
│                              │                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                     Data Layer                            │   │
│  │  ┌──────────────┐  ┌──────────────┐                      │   │
│  │  │ Product Model│  │  CartItem    │                      │   │
│  │  │  + Data      │  │   Model     │                      │   │
│  │  └──────────────┘  └──────────────┘                      │   │
│  └──────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘
                              │
                       Firebase Backend
                 (Auth · Firestore · Storage)
```

## 📂 Project Structure

```
Agribridge/
├── .github/workflows/dart.yml  # Flutter CI pipeline
├── .env.example                # Firebase config template
├── pubspec.yaml                # Flutter dependencies
├── lib/
│   ├── main.dart               # App entry point + Provider setup
│   ├── firebase_options.dart   # Firebase configuration
│   ├── data/
│   │   └── product_data.dart   # Centralized product catalog
│   ├── models/
│   │   ├── product.dart        # Product model with copyWith
│   │   └── cart_item.dart      # Cart item model with copyWith
│   ├── providers/
│   │   ├── auth_provider.dart  # Authentication state
│   │   ├── cart_provider.dart  # Shopping cart state
│   │   └── favorites_provider.dart
│   ├── screens/
│   │   ├── main_screen.dart    # Bottom navigation host
│   │   ├── home_page.dart      # Landing page with categories
│   │   ├── product_list_screen.dart  # Product grid + search
│   │   ├── cart_screen.dart    # Cart management
│   │   ├── checkout_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── contact_screen.dart
│   │   ├── vendor_form_screen.dart
│   │   └── vendor_opportunities_screen.dart
│   └── widgets/
│       └── floating_cart_button.dart
├── android/
├── ios/
├── web/
└── test/
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 3.0.0
- Android Studio or VS Code with Flutter extension
- Firebase project (for auth & database)

### Setup

```bash
# 1. Clone the repository
git clone https://github.com/silapareddy/Agribridge.git
cd Agribridge

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase
# Copy .env.example and fill in your Firebase credentials
# Then update lib/firebase_options.dart with your values
# See: https://console.firebase.google.com/

# 4. Run the app
flutter run
```

### Environment Variables

| Variable | Description | Where to find |
|----------|-------------|---------------|
| `FIREBASE_API_KEY` | Firebase API key | Firebase Console → Project Settings |
| `FIREBASE_APP_ID` | Firebase App ID | Firebase Console → Project Settings |
| `FIREBASE_PROJECT_ID` | Firebase Project ID | Firebase Console → Project Settings |
| `FIREBASE_AUTH_DOMAIN` | Auth domain | `{project-id}.firebaseapp.com` |
| `FIREBASE_STORAGE_BUCKET` | Storage bucket | `{project-id}.appspot.com` |

## ✨ Features

- 🛒 **Shopping Cart** — Add/remove products with quantity management
- 🔍 **Product Search** — Filter products by name or description in real-time
- 📋 **Product Categories** — Browse Vegetables and Lifestyle products
- 🧑‍🌾 **Vendor Registration** — Form with validation for farmer onboarding
- 👤 **Profile Management** — User profile and purchase history
- 📱 **Responsive UI** — Material Design 3 with green agricultural theme

## 🧰 Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.22** | Cross-platform UI framework |
| **Dart 3.x** | Programming language |
| **Provider** | State management |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | NoSQL database |
| **cached_network_image** | Image caching |
| **GitHub Actions** | CI/CD pipeline |

## 📸 Screenshots

| Home Page | Products | Cart | Vendor Registration |
|-----------|----------|------|---------------------|
| ![Home](https://github.com/user-attachments/assets/0ab57996-085d-471b-8a37-8026dcf7375d) | ![Products](https://github.com/user-attachments/assets/b56b2921-dc66-4ca0-b102-03132f76d6cd) | ![Cart](https://github.com/user-attachments/assets/89fd287b-4efd-42f0-acb2-36c7fef1ec1c) | ![Vendor](https://github.com/user-attachments/assets/22a3504f-15bd-45c5-a1d1-9e4c6d2b0e02) |

## LIVE DEMO
(https://agribridge911.netlify.app/)
