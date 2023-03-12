import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/authenticatio/user/otp_screen.dart';
class UserScreen extends StatefulWidget {
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
    final GlobalKey<FormState> _phoneFormKey = GlobalKey();
     late String phoneNumber;

     
    final _phoneController = TextEditingController(); 
     String _verificationId = "+20";

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







  Widget _buildIntroText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        const Image(
          height: 350,
          image: AssetImage(
            'images/phonenumber.png',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            'Please enter yout phone number to verify your account.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(){
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(30)
              ),
            ),
            child: Text(
              '${generateCountryFlag()} +20',
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
              ),
              borderRadius: const BorderRadius.all(
                  Radius.circular(30)
              ),
            ),
            child: TextFormField(
                controller: _phoneController,
              autofocus: true,
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none
              ),
              cursorColor: Colors.black,

              keyboardType: TextInputType.phone,
              validator: (value)
              {
                if (value!.isEmpty)
                {
                  return 'Please enter yout phone number!';
                }
                else if (value.length <11)
                  {
                    return 'Too short for a phone number!';
                  }
                return null;
              },

              onSaved: (value){
                phoneNumber = value!;
              }
            ),
          ),
        ),
      ],
    );
  }

  String generateCountryFlag(){
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(
       match.group(0)!.codeUnitAt(0) +127397
      )
    );
    return flag;
  }

  Widget _buildNextBotton(){
    return  Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
          onPressed: ()
          {
             Navigator.push(context, MaterialPageRoute(builder: (c)=>  OtpScreen()));
             _submitPhoneNumber;
          },
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        style: ElevatedButton.styleFrom(
          elevation: 2,
          minimumSize: const Size(110, 50), backgroundColor: const Color.fromARGB(
            255,
            79,
            115,
            17,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15,vertical:30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    _buildIntroText(),
                    const SizedBox(
                      height: 40,
                    ),
                    _buildPhoneField(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildNextBotton(),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


