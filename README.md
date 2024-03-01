# Flutter Note-Taking App with Firebase Integration

This Flutter project is a note-taking app that allows users to create, edit, and delete notes. The app uses Firebase for real-time data syncing, enabling users to seamlessly access their notes across multiple devices. Additionally, users can share their notes using dynamic links, making it easy to collaborate and share information with others.

## Features
- Create, and edit notes
- Real-time data syncing using Cloud Firestore
- Share notes with others using dynamic links
- User authentication (not included in this README)

## Installation
1. Clone this repository to your local machine.
2. Ensure you have Flutter installed. If not, follow the [Flutter installation instructions](https://flutter.dev/docs/get-started/install).
3. Install dependencies by running the following command in the project directory:
   ```
   flutter pub get
   ```
4. Ensure Firebase project setup:
   - Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).
   - Enable the Firestore database and set up rules.
   - Enable Firebase Dynamic Links and configure domain (optional).
   - Download `google-services.json` file (for Android) and `GoogleService-Info.plist` file (for iOS) and place them in the respective directories (`android/app` and `ios/Runner`).
5. Run the app on a simulator or physical device:
   ```
   flutter run
   ```

## Packages Used
- [cloud_firestore](https://pub.dev/packages/cloud_firestore): Flutter plugin for Firebase Cloud Firestore, a cloud-hosted, NoSQL database.
- [provider](https://pub.dev/packages/provider): State management library for Flutter applications.
- [firebase_core](https://pub.dev/packages/firebase_core): Flutter plugin for Firebase Core, which enables connecting to multiple Firebase apps in a single Flutter project.
- [share_plus](https://pub.dev/packages/share_plus): Flutter plugin for sharing content via the platform's share dialog.
- [firebase_dynamic_links](https://pub.dev/packages/firebase_dynamic_links): Flutter plugin for Firebase Dynamic Links, which allows creating, sending, and handling dynamic links.

## Usage
1. After launching the app, users can create a new note by tapping on the "+" button.
2. Users can edit existing notes by tapping on the note they wish to edit.
3. To delete a note, swipe left on the note and tap the delete button.
4. Users can share a note by tapping on the share icon and selecting the desired sharing option.

## Contributing
Contributions are welcome! If you have any suggestions, feature requests, or bug reports, please open an issue or submit a pull request.

## License
This project is licensed under the [MIT License](LICENSE). Feel free to modify and distribute the code for personal and commercial use.
