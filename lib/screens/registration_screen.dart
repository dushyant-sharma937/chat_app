import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            SizedBox(
              height: size.height * 0.35,
              width: size.width,
              child: Image.asset('images/Mobile login-amico.png',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Register ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
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
                      hintText: "Username",
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(205, 89, 88, 90),
                        fontWeight: FontWeight.bold,
                      ),
                      hoverColor: const Color.fromARGB(205, 89, 88, 90),
                      focusColor: const Color.fromARGB(205, 89, 88, 90),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: size.width,
                    height: 50,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () async {
                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim());
                      } on PlatformException catch (err) {
                        var message =
                            'An error occurred, please check your credentials!';
                        if (err.message != null) {
                          message = err.message!;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(message),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ));
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  ForgotPassword(size: size),
                ],
              ),
            ),
          ],
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
    return GestureDetector(
      onTap: () {
        // go to auth_screen
      },
      child: SizedBox(
        width: size.width,
        child: const Text(
          "Already registered? Sign in here",
          textAlign: TextAlign.right,
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Color.fromARGB(205, 54, 53, 54),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
