
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String _verificationId = "";

  bool _isPhoneNumberSubmitted = false;

  Future<void> _submitPhoneNumber() async {
    String phoneNumber = _phoneController.text;
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Fluttertoast.showToast(msg: "Error: ${authException.message}");
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _isPhoneNumberSubmitted = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> _submitCode() async {
    String smsCode = _codeController.text;
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Do something after successful sign-in
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Error: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Phone Authentication"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isPhoneNumberSubmitted
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: "Enter the verification code",
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitCode,
                      child: Text("Submit"),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "Enter your phone number",
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                    onPressed: _submitPhoneNumber,
                     child: Text("Submit"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}