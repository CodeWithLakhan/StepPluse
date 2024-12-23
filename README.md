
# StepPulse - Smartwatch Companion App

StepPulse is a Flutter-based smartwatch companion app designed to monitor and track health metrics such as heart rate, steps, and calories burned. The app integrates with Firebase and Firestore to provide real-time updates, historical tracking, and user authentication. The app also simulates a Bluetooth SDK for health data fetching.

---

## Features

### Authentication
- User login and account creation with Firebase Authentication (Email/Password).
- Toggle between login and sign-up forms.
- Error handling and user feedback.

### Dashboard
- Displays real-time health metrics (heart rate, steps, and calories burned).
- Smartwatch connectivity toggle with visual status.
- Automatic data synchronization to Firestore.
- Periodic data fetching every 10 seconds.

### History
- View historical health records fetched from Firestore.
- Modern UI with list-based scrolling.
- Error handling and loading indicators.

### Settings
- Toggle for smartwatch connectivity and app preferences.
- Options for data synchronization and notifications.

---

## Technologies Used

- **Flutter**: Frontend development framework.
- **Firebase Authentication**: For user login and account management.
- **Cloud Firestore**: Backend database for storing user profiles and health data.
- **Provider**: State management for authentication and health data.
- **Mock Bluetooth SDK**: Simulated SDK for fetching health metrics.

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone [<repository-url>](https://github.com/CodeWithLakhan/StepPluse)
cd steppulse
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup for Android
1. Create a Firebase project and enable Authentication and Cloud Firestore.
2. Download the `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.
3. Place these files in the respective directories:
    - `android/app/google-services.json`
    - `ios/Runner/GoogleService-Info.plist`

### 4. Run the App
```bash
flutter run
```

---

## Folder Structure
```
lib/
├── main.dart                 # App entry point
├── pages/                    # UI Screens
│   ├── login_page.dart       # Login and sign-up screen
│   ├── dashboard_page.dart   # Dashboard with real-time metrics
│   ├── history_page.dart     # Historical health records
│   ├── settings_page.dart    # User preferences and settings
├── provider/                 # State management
│   ├── auth_provider.dart    # Handles authentication
│   ├── healthdataprovider.dart # Manages health data
│   ├── firestore_service.dart # Firestore integration for user profiles and health records
```

---

## Demo Video
Watch the demo video of the StepPulse app in action: **[Demo Video - Google Drive](#)**

---

## Future Enhancements
- **Offline Mode**:
    - Cache historical records for offline viewing.
- **Data Insights**:
    - Provide visual charts and insights into user health trends.
- **Push Notifications**:
    - Notify users of irregular health metrics or activity reminders.

---

## Evaluation Criteria Mapping

### 1. Flutter Fundamentals
- Proper use of `StatelessWidget` and `StatefulWidget`.
- Clean code practices and logical widget tree structuring.
- Use of Provider for state management.

### 2. Backend & Database
- Firestore integration for storing user profiles and health data.
- Efficient data fetching and error handling.

### 3. SDK Integration
- Mock Bluetooth SDK used for real-time data fetching.
- Periodic health data updates (every 10 seconds).

### 4. UI/UX
- Adherence to modern design principles.
- Responsive and user-friendly interfaces.

### 5. Planning & Deliverability
- Clear code structure and detailed documentation.

### 6. Bonus Features
- Animations and custom widgets for enhanced UX.
- Secure authentication and data management.

---

## Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue for improvements or feature requests.
