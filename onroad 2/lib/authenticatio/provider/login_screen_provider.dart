// ignore_for_file: use_build_context_synchronously, body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onroad/authenticatio/provider/signup_screen.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/mainScreens/mainScreens_provider.dart';
import 'package:onroad/widgets/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool pass = true;

  validateForm() {
    if (!emailController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: $msg");
    }))
        .user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => const MainScreenProvider(),
        ),
      );
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      height: 300,
                      width: double.infinity,
                      image: AssetImage(
                        'images/Login.png',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 55.0,
                      width: 300.0,
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.go,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: (const TextStyle(
                            fontFamily: 'Brand Bold',
                            color: Colors.green,
                          )),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.green,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.green,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 55.0,
                      width: 300.0,
                      child: TextFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: pass,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: (const TextStyle(
                            fontFamily: 'Brand Bold',
                            color: Colors.green,
                          )),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                pass = !pass;
                              });
                            },
                            icon: const Icon(
                              Icons.visibility,
                              color: Colors.green,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 3,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => const ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 79, 115, 17),
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                      ),
                      width: 300,
                      height: 55.0,
                      child: MaterialButton(
                        onPressed: () async {
                          validateForm(); // التحقق من صحة النموذج أولاً

                          if (formKey.currentState!.validate()) {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setString('email', emailController.text);
                            Get.to(const MainScreenProvider());
                            loginDriverNow(); // تسجيل الدخول إذا تم اجتياز التحقق من النموذج
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Dont have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'SignUp ',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
