# Flutter Installation Guide

Flutter is an open-source UI software development toolkit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase. This guide will help you install Flutter on your system and set up your development environment.

## Table of Contents

- [System Requirements](#system-requirements)
- [Installing Flutter](#installing-flutter)
  - [Windows](#windows)
  - [macOS](#macos)
  - [Linux](#linux)
- [Setting Up Your Environment](#setting-up-your-environment)
- [Running Your First Flutter Application](#running-your-first-flutter-application)
- [Useful Commands](#useful-commands)
- [Troubleshooting](#troubleshooting)

## System Requirements

Before installing Flutter, make sure your system meets the following requirements:

### Windows

- Windows 10 or later (64-bit)
- 1.64 GB of free disk space
- Git for Windows (can be installed during Flutter setup)

### macOS

- macOS 10.14 or later
- Xcode 14.0 or later
- 2.8 GB of free disk space

### Linux

- Any modern Linux distribution (64-bit)
- 600 MB of free disk space
- `bash`, `curl`, `git`, `mkdir`, `rm`, `unzip`, `which` commands available

## Installing Flutter

### Windows

1. **Download Flutter SDK**
   - Download the Flutter SDK from the official Flutter website: [Flutter SDK for Windows](https://docs.flutter.dev/get-started/install/windows)
   - Extract the zip file to your desired installation location, for example, `C:\src\flutter` (do **not** install Flutter in a directory like `C:\Program Files\` that requires elevated privileges).

2. **Update Your Path**
   - Add the Flutter bin directory to your system's PATH:
     - From the Start search bar, type ‘env’ and select **Edit environment variables for your account**.
     - Under **User variables** check if there is an entry called `Path`:
       - If the entry exists, append `;C:\src\flutter\bin` to the end of the value.
       - If the entry does not exist, create a new user variable named `Path` with the value `C:\src\flutter\bin`.

3. **Install Git for Windows**
   - If Git for Windows is not already installed, download and install it from the [Git website](https://git-scm.com/).

### macOS

1. **Download Flutter SDK**
   - Download the Flutter SDK from the official Flutter website: [Flutter SDK for macOS](https://docs.flutter.dev/get-started/install/macos)
   - Extract the zip file and place the contained `flutter` in the desired installation location.

2. **Update Your Path**
   - Open a terminal and run the following command to update your `PATH`:
     ```bash
     export PATH="$PATH:`pwd`/flutter/bin"
     ```
   - To permanently add Flutter to your path, you can add the above line to your `.bashrc`, `.zshrc`, or `.bash_profile` file depending on your shell.

3. **Install Xcode**
   - Install Xcode from the App Store.
   - Open Xcode, then choose **Preferences > Locations** and select the latest version in the **Command Line Tools** dropdown.

4. **Accept Xcode License**
   - Run the following command to accept the Xcode license:
     ```bash
     sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
     sudo xcodebuild -runFirstLaunch
     ```

### Linux

1. **Download Flutter SDK**
   - Download the Flutter SDK from the official Flutter website: [Flutter SDK for Linux](https://docs.flutter.dev/get-started/install/linux)
   - Extract the tar file and place the contained `flutter` directory in the desired installation location.

2. **Update Your Path**
   - Open a terminal and run the following command to update your `PATH`:
     ```bash
     export PATH="$PATH:`pwd`/flutter/bin"
     ```
   - To permanently add Flutter to your path, you can add the above line to your `.bashrc` or `.bash_profile` file depending on your shell.

3. **Install Required Dependencies**
   - Run the following command to install dependencies:
     ```bash
     sudo apt-get update
     sudo apt-get install curl git xz-utils zip libglu1-mesa
     ```

## Setting Up Your Environment

1. **Run Flutter Doctor**
   - Open a terminal or command prompt and run the following command to check for any dependencies you may need to install:
     ```bash
     flutter doctor
     ```
   - Follow the instructions provided by `flutter doctor` to complete the setup.

2. **Install Android Studio (Optional)**
   - Download and install Android Studio from the [official website](https://developer.android.com/studio).
   - Open Android Studio, go to **Tools > SDK Manager**, and install the necessary SDK platforms and tools.

## Running Your First Flutter Application

1. **Create a New Flutter Project**
   - Open a terminal or command prompt and run:
     ```bash
     flutter create my_first_app
     ```
   - Navigate to the project directory:
     ```bash
     cd my_first_app
     ```

2. **Run the Application**
   - Connect a device or start an emulator.
   - Run the application:
     ```bash
     flutter run
     ```

## Useful Commands

- `flutter doctor` - Check your Flutter environment setup.
- `flutter create <app_name>` - Create a new Flutter project.
- `flutter run` - Run your Flutter application.
- `flutter build` - Build your Flutter application for deployment.
- `flutter pub get` - Install dependencies from `pubspec.yaml`.

## Troubleshooting

- If you encounter any issues during installation or setup, refer to the [Flutter documentation](https://flutter.dev/docs) or the [Flutter community forums](https://flutter.dev/community).

Happy coding with Flutter!
