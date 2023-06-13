// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/authenticatio/user/user_login.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/widgets/progress_dialog.dart';
import '../../mainScreens/main_screens.dart';

class SignUpScreenUser extends StatefulWidget {
  const SignUpScreenUser({super.key});

  @override
  State<SignUpScreenUser> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreenUser> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool pass = true;

  validateForm() {
    if (fnameController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
    } else if (!emailController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    } else if (phoneController.text.length > 11) {
      Fluttertoast.showToast(
          msg: "Phone Number is required.Enter only 11 numbers");
    } else if (passwordController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 Characters.");
    } else if (passwordController.text != confirmpasswordController.text) {
      Fluttertoast.showToast(msg: "Password Do not match");
    } else {
      saveDriverInfoNow();
    }
  }

  saveDriverInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: $msg");
    }))
        .user;

    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "fname": fnameController.text.trim(),
        "lname": lnameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("userrrrs");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => const MainScreen(),
        ),
      );
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          15.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: Image(
                    height: 250.0,
                    image: AssetImage(
                      'images/signup.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 52.0,
                        width: 145.0,
                        child: TextFormField(
                          controller: fnameController,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            labelStyle: (const TextStyle(
                              fontFamily: 'Brand Bold',
                              color: Colors.green,
                            )),
                            prefixIcon: const Icon(
                              Icons.person,
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
                        width: 10.0,
                      ),
                      SizedBox(
                        height: 52.0,
                        width: 145.0,
                        child: TextFormField(
                          controller: lnameController,
                          textInputAction: TextInputAction.go,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: (const TextStyle(
                              fontFamily: 'Brand Bold',
                              color: Colors.green,
                            )),
                            prefixIcon: const Icon(
                              Icons.person,
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  height: 52.0,
                  width: 300.0,
                  child: TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
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
                  height: 15.0,
                ),
                SizedBox(
                  height: 52.0,
                  width: 300.0,
                  child: TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: (const TextStyle(
                        fontFamily: 'Brand Bold',
                        color: Colors.green,
                      )),
                      prefixIcon: const Icon(
                        Icons.phone,
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
                  height: 10.0,
                ),
                SizedBox(
                  height: 52.0,
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
                  height: 10.0,
                ),
                SizedBox(
                  height: 52.0,
                  width: 300.0,
                  child: TextFormField(
                    controller: confirmpasswordController,
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
                      labelText: 'Confirm Password',
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
                  height: 15.0,
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
                  height: 52.0,
                  width: 300.0,
                  child: MaterialButton(
                    onPressed: () {
                      validateForm();
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontFamily: 'Brand Bold',
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Do you have an account ?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => const LoginScreenUser()));
                      },
                      child: const Text(
                        'Login',
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
    );
  }
}
