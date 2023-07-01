import 'package:chat_app/screens/chat_screen.dart';

import '../screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          brightness: Brightness.light,
          onPrimary: Color(0xffD6E2EA),
          onSecondary: Colors.purple,
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 28, 20, 12),
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 28,
            color: Color.fromARGB(255, 28, 20, 12),
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 28, 20, 12),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return const ChatScreen();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
