import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talkio/Global.dart';
import 'package:talkio/ProviderHandler.dart';
import 'package:talkio/firebase_options.dart';
import 'package:talkio/services/MessagingService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    await MessagingService.initialize();
  } catch (error) {
    // Put something here
  }
  runApp(providerHandler);
}
