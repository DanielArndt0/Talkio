import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:training_app/ProviderHandler.dart';
import 'package:training_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);  
  runApp(providerHandler);
}
