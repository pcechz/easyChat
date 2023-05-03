# EasyChat

EasyChat is a simple, yet powerful chat application built using Flutter and Firebase. It utilizes the BLoC/Cubit model for state management and Google Authentication for user sign-in and sign-up. The app offers an intuitive interface with pages for sign-in, sign-up, chat list, and chat room, making it a perfect choice for creating your own messaging app.

# Features

Real-time messaging
One-to-one and group chats
Firebase Firestore for storing messages and chat data
Firebase Storage for media attachments (images, videos, etc.)
Google Authentication for sign-in and sign-up
BLoC/Cubit for state management
Clean and modern UI/UX

# Getting Started

Prerequisites

Ensure you have the following software installed:

Flutter SDK
Dart SDK
Android Studio or Visual Studio Code (with Flutter and Dart plugins)
Firebase CLI

# Setup

1. Clone this repository to your local machine:
git clone https://github.com/pcechz/easyChat.git
2. Navigate to the project directory: 
   cd easychat
3. Install the required packages:
  flutter pub get
4. Set up a new Firebase project and enable the following services:

   Firestore
   Firebase Storage
   Google Authentication

5. Download the google-services.json file from the Firebase console and place it in the android/app directory.

6. Run the app on your preferred device or emulator:
   flutter run

 
