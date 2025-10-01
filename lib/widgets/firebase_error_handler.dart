import 'package:firebase_auth/firebase_auth.dart';

class FirebaseErrorHandler {
  static String handleFirebaseError(dynamic error) {
    // Firebase Auth errors
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'Invalid email address.';
        case 'user-disabled':
          return 'This user account has been disabled.';
        case 'user-not-found':
          return 'No user found with this email.';
        case 'wrong-password':
          return 'Incorrect password.';
        case 'email-already-in-use':
          return 'This email is already in use.';
        case 'weak-password':
          return 'Password is too weak.';
        case 'operation-not-allowed':
          return 'This sign-in method is not allowed.';
        case 'too-many-requests':
          return 'Too many login attempts. Please try again later.';
        case 'network-request-failed':
          return 'No internet connection.';
        case 'invalid-credential':
          return 'Incorrect password or email. Please try again';
        default:
          return 'Authentication error occurred.';
      }
    }

    // Firebase Firestore / General Firebase errors
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return 'You do not have permission to access this data.';
        case 'unavailable':
          return 'Service is temporarily unavailable. Try again later.';
        case 'deadline-exceeded':
          return 'Request timed out. Please check your connection.';
        case 'not-found':
          return 'Requested data not found.';
        case 'resource-exhausted':
          return 'Quota limit reached. Try again later.';
        default:
          return error.message ?? 'Firebase error occurred.';
      }
    }

    // Other unexpected errors
    return 'An unexpected error occurred: ${error.toString()}';
  }
}
