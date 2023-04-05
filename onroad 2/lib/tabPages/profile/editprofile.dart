
import 'package:flutter/material.dart';
import 'package:onroad/tabPages/profile/profile_TabPage.dart';

//import 'package:onroad/splashScreen/splash_Screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool pass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 115, 17),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => const ProfileTabPage(),
              ),
            );
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Brand Bold',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                  [
                    const SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 55.0,
                      width: 300.0,
                      child: TextFormField(
                        controller: nameController,
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
                        controller: passwordController,
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
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Colors.green,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => const ProfileTabPage(),
                                ),
                              );
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

                            },
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
      ),
    );
  }
}
