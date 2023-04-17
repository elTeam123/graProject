// ignore_for_file: sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Password reset link sent! check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          79,
          115,
          17,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Image(
              height: 300,
              width: double.infinity,
              image: AssetImage(
                'images/Forgot password.png',
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Enter Your Email and we well send you a password rest link",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Brand Bold',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.5),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: (const TextStyle(
                    fontFamily: 'Brand Bold',
                    color: Color.fromARGB(
                      255,
                      79,
                      115,
                      17,
                    ),
                  )),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Color.fromARGB(
                      255,
                      79,
                      115,
                      17,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                          255,
                          79,
                          115,
                          17,
                        ),
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                          255,
                          79,
                          115,
                          17,
                        ),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  79,
                  115,
                  17,
                ),
                borderRadius: BorderRadius.circular(
                  30.0,
                ),
              ),
              width: 200,
              height: 55.0,
              child: MaterialButton(
                onPressed: passwordReset,
                child: const Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontFamily: 'Brand Bold',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
