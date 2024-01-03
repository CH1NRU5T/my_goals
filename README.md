# Goals Project Setup Guide

This guide will help you set up and run a Flutter project from a GitHub repository.

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
   git clone https://github.com/username/repository-name.git
   ```

   Replace `username` with the GitHub username and `repository-name` with the name of the repository.

3. Navigate to the project directory:

   ```bash
   cd repository-name
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
