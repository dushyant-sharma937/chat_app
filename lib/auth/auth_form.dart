import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.submitFn,
    required this.isLoading,
  });
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigFailure;
  SMIInput<bool>? trigSuccess;

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    isHandsUp!.change(false);
    final isValid = _formKey.currentState!.validate();

    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }

    // Use those values to send auth requests.........
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: size.height * 0.1),
            Container(
              height: size.height * 0.12,
            ),
            SizedBox(
              width: size.width,
              height: MediaQuery.of(context).size.height * 0.33,
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
            // SizedBox(height: size.height * 0.25),
            Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      key: const ValueKey('email'),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter a valid email address.';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _userEmail = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color.fromARGB(205, 0, 0, 0),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(205, 89, 88, 90),
                          fontWeight: FontWeight.bold,
                        ),
                        hoverColor: const Color.fromARGB(205, 0, 0, 0),
                        focusColor: const Color.fromARGB(205, 0, 0, 0),
                        prefixIcon: const Icon(Icons.mail),
                        prefixIconColor: const Color.fromARGB(205, 89, 88, 90),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(205, 0, 0, 0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (isHandsUp != null) {
                          isHandsUp!.change(false);
                        }
                        if (isChecking == null) return;

                        isChecking!.change(true);
                      },
                    ),
                    if (!_isLogin) const SizedBox(height: 10),
                    if (!_isLogin)
                      TextFormField(
                        key: const ValueKey('username'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username.';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _userName = value!;
                        },
                        cursorColor: const Color.fromARGB(205, 0, 0, 0),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(205, 89, 88, 90),
                            fontWeight: FontWeight.bold,
                          ),
                          hoverColor: const Color.fromARGB(205, 0, 0, 0),
                          focusColor: const Color.fromARGB(205, 0, 0, 0),
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor:
                              const Color.fromARGB(205, 89, 88, 90),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(205, 0, 0, 0),
                            ),
                          ),
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
                      key: const ValueKey('password '),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must be atleast 8 characters long.';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _userPassword = value!;
                      },
                      cursorColor: const Color.fromARGB(205, 0, 0, 0),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(205, 89, 88, 90),
                          fontWeight: FontWeight.bold,
                        ),
                        hoverColor: const Color.fromARGB(205, 0, 0, 0),
                        focusColor: const Color.fromARGB(205, 0, 0, 0),
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: const Color.fromARGB(205, 89, 88, 90),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(205, 0, 0, 0),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (isChecking != null) {
                          isChecking!.change(false);
                        }
                        if (isHandsUp == null) return;

                        isHandsUp!.change(true);
                      },
                    ),
                    if (_isLogin) const SizedBox(height: 10),
                    if (_isLogin)
                      SizedBox(
                        width: size.width,
                        child: const Text(
                          "Forgot your Password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(205, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (widget.isLoading) const CircularProgressIndicator(),
                    if (!widget.isLoading)
                      MaterialButton(
                        onPressed: _trySubmit,
                        minWidth: size.width,
                        height: 50,
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          _isLogin ? "Log in" : "Register",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      ),
                    // const SizedBox(height: 10),
                    if (!widget.isLoading)
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _isLogin
                                  ? "Don't you have an account?"
                                  : "Already have an account?",
                              style: const TextStyle(
                                  color: Color.fromARGB(205, 0, 0, 0)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin ? "Register here" : "Log in here",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
