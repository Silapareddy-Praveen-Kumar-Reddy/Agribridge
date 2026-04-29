import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated =>
      true; // Always return true since we're not using auth

  // Placeholder methods that do nothing
  Future<void> signOut() async {}
  Future<bool> isUserLoggedIn() async => true;
}
