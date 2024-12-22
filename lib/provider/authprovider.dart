import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Track whether the user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  bool isLogin = true; // Toggles between login and create account
  String? errorMessage;

  User? get currentUser => _auth.currentUser; // Get current logged-in user

  AuthProvider() {
    // Listen for authentication state changes
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        saveUserProfile(); // Automatically save/update the user's profile on login
      }
      notifyListeners(); // Notify listeners when the auth state changes
    });
  }

  void toggleFormType() {
    isLogin = !isLogin;
    notifyListeners();
  }

  Future<void> submit(String email, String password) async {
    try {
      errorMessage = null;
      if (isLogin) {
        // Login functionality
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        saveUserProfile(); // Save the profile on successful login
      } else {
        // Create account functionality
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        isLogin = true; // Switch back to login view after sign-up
        saveUserProfile(); // Save the profile on successful sign-up
      }
      notifyListeners();
    } catch (e) {
      errorMessage = _handleAuthError(e.toString());
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      errorMessage = _handleAuthError(e.toString());
      notifyListeners();
    }
  }

  Future<void> saveUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestoreService.saveUserProfile(user.uid, {
          'name': user.displayName ?? 'Guest',
          'email': user.email,
          'lastLogin': DateTime.now().toIso8601String(),
        });
      } catch (e) {
        errorMessage = 'Failed to save user profile: $e';
        notifyListeners();
      }
    }
  }

  String? _handleAuthError(String error) {
    if (error.contains('email-already-in-use')) {
      return 'This email is already registered.';
    } else if (error.contains('user-not-found')) {
      return 'No user found with this email.';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Please check your internet connection.';
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }
}
