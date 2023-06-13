// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderEditProfile extends StatefulWidget {
  const ProviderEditProfile({super.key});

  @override
  State<ProviderEditProfile> createState() => _ProviderEditProfile();
}

class _ProviderEditProfile extends State<ProviderEditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Brand Bold',
            fontWeight: FontWeight.w500,
            color: Colors.grey[200],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipPath(
                    clipper: CustomShape(),
                    child: Container(
                      color: Colors.green,
                      height: 200.0,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    height: 55.0,
                    width: 300.0,
                    child: TextFormField(
                      controller: _fullNameController,
                      textInputAction: TextInputAction.go,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Full Name must not be empty';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                          ),
                        ),
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
                      controller: _phoneNumberController,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
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
                            width: 3,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 79, 115, 17),
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        width: 150.0,
                        height: 50.0,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'Brand Bold',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 79, 115, 17),
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ),
                        ),
                        width: 150.0,
                        height: 50.0,
                        child: MaterialButton(
                          onPressed: () {},
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'Brand Bold',
                            ),
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
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(
      width / 2,
      height,
      width,
      height - 100,
    );
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
