// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigFailure;
  SMIInput<bool>? trigSuccess;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: RiveAnimation.asset(
                    "images/animated_login_character.riv",
                    stateMachines: const ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                          artboard, "Login Machine");
                      if (controller == null) return;
                      artboard.addController(controller!);
                      isChecking = controller?.findInput("isChecking");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigFailure = controller?.findInput("trigFailure");
                      trigSuccess = controller?.findInput("trigSuccess");
                    },
                  ),
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color.fromARGB(205, 89, 88, 90),
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        prefixIconColor: const Color.fromARGB(205, 89, 88, 90),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(205, 89, 88, 90),
                          ),
                        ),
                        hintText: "E mail",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(205, 89, 88, 90),
                          fontWeight: FontWeight.bold,
                        ),
                        hoverColor: const Color.fromARGB(205, 89, 88, 90),
                        focusColor: const Color.fromARGB(205, 89, 88, 90),
                        prefixIcon: const Icon(Icons.mail),
                      ),
                      onChanged: (value) {
                        if (isHandsUp != null) {
                          isHandsUp!.change(false);
                        }
                        if (isChecking == null) return;

                        isChecking!.change(true);
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      cursorColor: const Color.fromARGB(205, 89, 88, 90),
                      style: const TextStyle(fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                        prefixIconColor: const Color.fromARGB(205, 89, 88, 90),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(205, 89, 88, 90),
                          ),
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(205, 89, 88, 90),
                          fontWeight: FontWeight.bold,
                        ),
                        hoverColor: const Color.fromARGB(205, 89, 88, 90),
                        focusColor: const Color.fromARGB(205, 89, 88, 90),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      onChanged: (value) {
                        if (isChecking != null) {
                          isChecking!.change(false);
                        }
                        if (isHandsUp == null) return;

                        isHandsUp!.change(true);
                      },
                    ),
                    const SizedBox(height: 10),
                    ForgotPassword(size: size),
                    const SizedBox(height: 10),
                    MaterialButton(
                      minWidth: size.width,
                      height: 50,
                      color: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email, password: password);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't you have an account?",
                            style: TextStyle(
                                color: Color.fromARGB(205, 89, 88, 90)),
                          ),
                          TextButton(
                            onPressed: () {
                              //register code
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 42, 42, 42),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: const Text(
        "Forgot your Password?",
        textAlign: TextAlign.right,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Color.fromARGB(205, 89, 88, 90),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
