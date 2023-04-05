// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:onroad/authenticatio/provider/login_screen_provider.dart';
// import 'package:onroad/mainScreens/main_screens.dart';
//
// import '../../assistants/conest.dart';

// class SignUpScreenUser extends StatefulWidget {
//   const SignUpScreenUser({super.key});
//
//   @override
//   State<SignUpScreenUser> createState() => _SignUpScreenUser();
// }

//  class _SignUpScreenUser extends State<SignUpScreenUser> {
//   final databaseReference = FirebaseDatabase.instance.ref();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   var formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     countryController.text = "+2";
//     super.initState();
//   }
//
//   validateForm() {
//     if (_firstNameController.text.length < 3) {
//       Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
//     } else if (_lastNameController.text.length < 3) {
//       Fluttertoast.showToast(msg: "name must be at least 3 Characters.");
//     } else if (_phoneNumberController.text.isEmpty) {
//       Fluttertoast.showToast(msg: "Phone Number is required.");
//     } else {
//       _saveData();
//       Navigator.push(
//           context, MaterialPageRoute(builder: (c) => const MainScreen()));
//     }
//   }
//
//   void _saveData() {
//     String firstName = _firstNameController.text;
//     String lastName = _lastNameController.text;
//     String phoneNumber = _phoneNumberController.text;
//
//     databaseReference.child("users").push().set({
//       'first_name': firstName,
//       'last_name': lastName,
//       'phone_number': phoneNumber
//     }).then((value) => {
//           _firstNameController.clear(),
//           _lastNameController.clear(),
//           _phoneNumberController.clear(),
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(
//           15.0,
//         ),
//         child: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(top: 10),
//                   child: Image(
//                     height: 170.0,
//                     image: AssetImage(
//                       'images/signup.png',
//                     ),
//                   ),
//                 ),
//                 const Text(
//                   'SignUp Here',
//                   style: TextStyle(
//                     fontFamily: 'Signatra',
//                     fontSize: 50,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 3.0,
//                 ),
//                 const SizedBox(
//                   height: 80.0,
//                 ),
//                 SizedBox(
//                   height: 52.0,
//                   width: 300.0,
//                   child: TextFormField(
//                     controller: _firstNameController,
//                     keyboardType: TextInputType.name,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'First name must not be empty';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'First name',
//                       labelStyle: (const TextStyle(
//                         fontFamily: 'Brand Bold',
//                         color: Colors.green,
//                       )),
//                       prefixIcon: const Icon(
//                         Icons.phone,
//                         color: Colors.green,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                             color: Colors.green,
//                           )),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                             color: Colors.green,
//                           )),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 SizedBox(
//                   height: 52.0,
//                   width: 300.0,
//                   child: TextFormField(
//                     controller: _lastNameController,
//                     keyboardType: TextInputType.name,
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Last name must not be empty';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Lsat name',
//                       labelStyle: (const TextStyle(
//                         fontFamily: 'Brand Bold',
//                         color: Colors.green,
//                       )),
//                       prefixIcon: const Icon(
//                         Icons.person_4,
//                         color: Colors.green,
//                       ),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                             color: Colors.green,
//                           )),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           borderSide: const BorderSide(
//                             color: Colors.green,
//                           )),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 Container(
//                   height: 55,
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: Colors.grey),
//                       borderRadius: BorderRadius.circular(30)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       SizedBox(
//                         width: 40,
//                         child: TextField(
//                           controller: countryController,
//                           keyboardType: TextInputType.number,
//                           decoration: const InputDecoration(
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       const Text(
//                         "|",
//                         style: TextStyle(fontSize: 33, color: Colors.grey),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                           child: TextField(
//                             onChanged: (value) {
//                               var phone = value;
//                             },
//                             keyboardType: TextInputType.phone,
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               hintText: "Phone",
//                             ),
//                           ))
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 80.0,
//                 ),
//                 SizedBox(
//                   height: 52.0,
//                   width: 300.0,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 79, 115, 17),
//                       elevation: 4,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                     onPressed: () {
//                       PhoneUser();
//                     },
//                     child: const Text(
//                       "Send the code",
//                       style: TextStyle(
//                         fontFamily: 'Brand Bold',
//                         fontSize: 19,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text('Do you have an account ?'),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (c) => LoginScreen()));
//                       },
//                       child: const Text(
//                         'Login Here',
//                         style: TextStyle(
//                           color: Colors.green,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
