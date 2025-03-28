import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FbAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  FbAuthProvider() {
    _auth.idTokenChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  FirebaseAuth get auth => _auth;
  User? get user => _user;
}
