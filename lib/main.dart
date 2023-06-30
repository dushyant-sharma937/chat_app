import 'package:chat_app/screens/registration_screen.dart';

import '../screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primaryColor: const Color(0xffD6E2EA),
        colorScheme: const ColorScheme.light(
          onPrimary: Color(0xffD6E2EA),
          onSecondary: Colors.purple,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 28, 20, 12),
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            fontSize: 28,
            color: Color.fromARGB(255, 28, 20, 12),
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 28, 20, 12),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: RegisterScreen(),
    );
  }
}
