import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:onroad/authenticatio/user/otp.dart';
import 'package:onroad/authenticatio/user/user_login.dart';

class SignUpScreenUser extends StatefulWidget {
  const SignUpScreenUser({super.key});
  static String Verify = '';

  @override
  State<SignUpScreenUser> createState() => _SignUpScreenUser();
}

class _SignUpScreenUser extends State<SignUpScreenUser> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var phone = '';

  validateForm() {
    if (_firstNameController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
    } else if (_lastNameController.text.length < 3) {
      Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
    } else if (_phoneNumberController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    } else {
      _saveData();
    }
  }

  void _saveData() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String phoneNumber = _phoneNumberController.text;

    databaseReference.child("users").push().set({
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber
    }).then((value) => {
          _firstNameController.clear(),
          _lastNameController.clear(),
          _phoneNumberController.clear(),
        });
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  Future<void> _submitPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+20${_phoneNumberController.text + phone}',
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException authException) {
        Fluttertoast.showToast(msg: "Error: ${authException.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        SignUpScreenUser.Verify = verificationId;
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => const MyVerify()));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    showProgressIndicator(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Image.asset('images/2.png'),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 52.0,
                  width: 300.0,
                  child: TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'First name must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First name',
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
                  height: 20.0,
                ),
                SizedBox(
                  height: 52.0,
                  width: 300.0,
                  child: TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Last name must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Lsat name',
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
                  height: 20.0,
                ),
                SizedBox(
                  height: 70.0,
                  width: 300.0,
                  child: IntlPhoneField(
                    initialCountryCode: 'EG',
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
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
                  height: 20.0,
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
                      _submitPhoneNumber();
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const UserLogin(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login Here',
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
