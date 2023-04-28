// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:onroad/authenticatio/user/user_login.dart';
// import 'package:onroad/mainScreens/main_screens.dart';
// import 'package:pinput/pinput.dart';
//
// class MyVerify extends StatefulWidget {
//   const MyVerify({Key? key}) : super(key: key);
//
//   @override
//   State<MyVerify> createState() => _MyVerifyState();
// }
//
// class _MyVerifyState extends State<MyVerify> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(
//       fontSize: 20,
//        color: Color.fromRGBO(30, 60, 87, 1),
//           fontWeight: FontWeight.w600),
//         decoration: BoxDecoration(
//         border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
//       borderRadius: BorderRadius.circular(8),
//     );
//
//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: const Color.fromRGBO(234, 239, 243, 1),
//       ),
//     );
//
//     var code = '';
//
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_rounded,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: Container(
//         margin: const EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children:
//             [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Image.asset('images/x.png'),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               const Text(
//                 "Verification code",
//                 style: TextStyle(
//                   fontSize: 23,
//                   fontFamily: 'Brand Bold',
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "Please type in the code ",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Pinput(
//                 length: 6,
//                 // defaultPinTheme: defaultPinTheme,
//                 // focusedPinTheme: focusedPinTheme,
//                 // submittedPinTheme: submittedPinTheme,
//
//                 showCursor: true,
//                 // ignore: avoid_print
//                 onCompleted: (pin) => print(pin),
//                 onChanged: (value) {
//                   code = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               SizedBox(
//                 height: 50.0,
//                 width: 300.0,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 79, 115, 17),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30))),
//                   onPressed: () async {
//                     try {
//                       PhoneAuthCredential credential =
//                       PhoneAuthProvider.credential(
//                          verificationId: UserLogin.Verify, smsCode: code);
//
//                       // Sign the user in (or link) with the credential
//                       await auth.signInWithCredential(credential);
//                       // ignore: use_build_context_synchronously
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (c) => const MainScreen()));
//                     } on FirebaseAuthException catch (e) {
//                       Fluttertoast.showToast(msg: "Error: ${e.message}");
//                     }
//                   },
//                   child: const Text(
//                     "Verify Phone Number",
//                     style: TextStyle(
//                       fontFamily: 'Brand Bold',
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (c) => const UserLogin()));
//                       },
//                       child: const Text(
//                         "Edit Phone Number ?",
//                         style: TextStyle(color: Colors.black),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }