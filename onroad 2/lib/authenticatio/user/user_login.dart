import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  static String Verify = '';

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController countryController = TextEditingController();
  var phone = '';

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
      phoneNumber: '+20${countryController.text + phone}',
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException authException) {
        Fluttertoast.showToast(msg: "Error: ${authException.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        UserLogin.Verify = verificationId;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const UserLogin(),
          ),
        );
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
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Image.asset('images/phonenumber.png'),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Brand Bold',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please enter yout phone number to verify your account !",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 75.0,
                width: 300.0,
                child: IntlPhoneField(
                  initialCountryCode: 'EG',
                  controller: countryController,
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
                height: 20,
              ),
              SizedBox(
                height: 52.0,
                width: 300.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 79, 115, 17),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    _submitPhoneNumber();
                  },
                  child: const Text(
                    "Send the code",
                    style: TextStyle(
                      fontFamily: 'Brand Bold',
                      fontSize: 19,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}