import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/user/otp_screen.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  final phoneController = TextEditingController();
  bool showLoading = false;
  String verificationFailedMessage = "";

    String generateCountryFlag(){
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
      (match) => String.fromCharCode(
       match.group(0)!.codeUnitAt(0) +127397
      )
    );
    return flag;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:
                    [
                       Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: const Image(
                        height: 350,
                        image: AssetImage(
                         'images/phonenumber.png',
                                     ),
                                     ),
                    ),
                       Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      'Please enter yout phone number to verify your account +20',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,

                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 22,
                      ),
                       Row(
                        children:
                        [
                           Container(
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
                           const SizedBox(
                            width: 7,
                           ),
                           Container(
                            width: 230,
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
                        controller: phoneController,
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
                            ),
                          ),
                        ],
                       ),
                     const SizedBox(
                        height: 22,
                      ),
                         ElevatedButton(
                     onPressed: () async {

                      setState(() {
                     showLoading = true;
                      });
                      await FirebaseAuth.instance.verifyPhoneNumber(

                  phoneNumber: phoneController.text,
                  verificationCompleted: (PhoneAuthCredential credential) {},
                  verificationFailed: (FirebaseAuthException e) {
                    setState(() {
                      showLoading = false;
                    });
                    setState(() {
                      verificationFailedMessage = e.message ?? "error!";
                    });
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    setState(() {
                      showLoading = false;
                    });
                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(isTimeOut2: false , verificationId:verificationId)));
                  },
                  timeout: const Duration(seconds: 10),
                  codeAutoRetrievalTimeout: (String verificationId) {

                    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_,__,___) => OTPPage(isTimeOut2: true ,verificationId:verificationId)));

                          },
                        );
                      },
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
                  child: const Text(
                  'Next',
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  ),
                  ),
                    ),
                      Text(verificationFailedMessage),
                    ],
                  ),
        ),
    ));
  }
}