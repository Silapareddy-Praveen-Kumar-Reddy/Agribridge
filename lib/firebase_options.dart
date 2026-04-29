import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // TODO: Replace these values with your Firebase project configuration
    // To get these values:
    // 1. Go to Firebase Console (https://console.firebase.google.com/)
    // 2. Select your project
    // 3. Click on the gear icon (⚙️) next to "Project Overview"
    // 4. In the "Your apps" section, find your web app or add a new one
    // 5. Copy the configuration values from there
    return const FirebaseOptions(
      apiKey: 'YOUR_API_KEY', // Replace with your API key
      appId: 'YOUR_APP_ID', // Replace with your App ID
      messagingSenderId:
          'YOUR_MESSAGING_SENDER_ID', // Replace with your Messaging Sender ID
      projectId: 'YOUR_PROJECT_ID', // Replace with your Project ID
      authDomain:
          'YOUR_AUTH_DOMAIN', // Replace with your Auth Domain (usually project-id.firebaseapp.com)
      storageBucket:
          'YOUR_STORAGE_BUCKET', // Replace with your Storage Bucket (usually project-id.appspot.com)
    );
  }
}
