import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../authenticatio/user/otp.dart';
import '../authenticatio/user/user_login (2).dart';

TextEditingController countryController = TextEditingController();
var phone = '';
PhoneUser() async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: countryController.text + phone,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {
      MyPhone.verify = verificationId;
      Navigator.push(context as BuildContext,
          MaterialPageRoute(builder: (c) => const MyVerify()));
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
