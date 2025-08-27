# 🎬 Movie Explorer App

A beautiful and modern Flutter application for exploring popular movies with an elegant dark theme UI and smooth animations.

## ✨ Features

### 🎭 Core Functionality
- **50 Popular Movies**: Curated list of top-rated movies from IMDb
- **Movie Details**: Comprehensive information including plot, cast, director, genre, and ratings
- **Favorites System**: Save and manage your favorite movies locally
- **Search & Filter**: Find movies quickly with built-in search functionality
- **Responsive Design**: Works seamlessly on mobile, tablet, and desktop

### 🎨 UI/UX Features
- **Modern Dark Theme**: Elegant purple gradient design with Material 3
- **Smooth Animations**: Fluid transitions and micro-interactions
- **Custom Navigation**: Beautiful glassmorphic bottom navigation bar
- **Cached Images**: Fast loading with cached network images
- **Custom Widgets**: Reusable aesthetic components

### 📱 Screens
1. **Movies List Screen**: Browse 50 popular movies with poster grid
2. **Movie Detail Screen**: Detailed view with full movie information
3. **Favorites Screen**: Manage your saved favorite movies
4. **Profile Screen**: User preferences and app settings

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **HTTP Client**: http package
- **Local Storage**: SharedPreferences
- **Image Caching**: cached_network_image
- **Fonts**: Google Fonts (Inter)
- **API**: OMDb API for movie data

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  http: ^1.1.0
  provider: ^6.0.5
  shared_preferences: ^2.2.2
  cached_network_image: ^3.3.0
  google_fonts: ^6.1.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- OMDb API Key (get from [OMDb API](http://www.omdbapi.com/apikey.aspx))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AyeshaAppDev/movie_explorer_app.git
   cd movie_explorer_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   - Open `lib/services/movie_service.dart`
   - Replace `YOUR_OMDB_API_KEY` with your actual OMDb API key
   ```dart
   static const String _apiKey = 'your_api_key_here';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

![6](https://github.com/user-attachments/assets/d0129319-fbf1-488d-92c0-22266b1807db)
![5](https://github.com/user-attachments/assets/8fd15f0d-60af-411c-b6a3-99b0491f0bc2)
![4](https://github.com/user-attachments/assets/2881d458-4c4b-4448-906f-9e2ab982338a)
![3](https://github.com/user-attachments/assets/19bb2663-69a1-4dcb-8ee1-dcbff4eca959)
![2](https://github.com/user-attachments/assets/f5866e94-ee5e-44e0-837d-18ade23eeaea)
![1](https://github.com/user-attachments/assets/6e30d544-e813-48ec-a66e-d900d21d64b2)
