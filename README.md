# Goals Project Setup Guide

This guide will help you set up and run a Flutter project from a GitHub repository.

## Features
- [X] Google Sign In.
- [X] Real-time data retrieval with Firestore.
- [X] UI state management to reflect changes in data.
- [X] Data-driven calculations and UI updates.

### Firestore rules that restrict access to authenticated users only
```
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Demo Video
[Demo Video Link](https://drive.google.com/file/d/1R4jPgzJHnNNJtyr-ii_hHDTbrSPWWsW6/view)

## Prerequisites

- Ensure you have Flutter installed. Check the Flutter version on your system:

  ```bash
  flutter --version
  ```

  If Flutter is not installed, follow the official Flutter installation guide at [Flutter.dev](https://flutter.dev/docs/get-started/install).

- Have Git installed on your machine. You can download it from [Git - Downloads](https://git-scm.com/downloads).

## Clone the Repository

1. Open your terminal or command prompt.

2. Clone the repository using the following command:

   ```bash
   git clone https://github.com/CH1NRU5T/my_goals
   ```

3. Navigate to the project directory:

   ```bash
   cd my_goals
   ```

## Running the Project

1. Ensure you have an emulator/device connected or running.

2. Run the following command to get dependencies:

   ```bash
   flutter pub get
   ```

3. To run the project, use:

   ```bash
   flutter run
   ```

   This will launch the app on the connected emulator/device.
