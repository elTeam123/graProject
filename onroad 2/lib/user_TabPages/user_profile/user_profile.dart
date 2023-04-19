// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/user_or_providr.dart';
import 'package:onroad/mainScreens/main_screens.dart';
import 'package:onroad/user_TabPages/user_profile/user_editprofile.dart';
import 'package:onroad/user_TabPages/user_profile/user_icon.dart';
import 'package:onroad/user_TabPages/user_profile/user_info.dart';


class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  String? name;
  String? image;

  final _mAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const MainScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Brand Bold',
            fontWeight: FontWeight.w500,
            color: Colors.grey[200],
          ),
        ),
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const EditProfile(),
                ),
              );
            },
            child: Text(
              'Edit',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Brand Bold',
                fontWeight: FontWeight.w500,
                color: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children:
        [
          const Info(),
          const SizedBox(
            height: 50.0,
          ),
          ProfileMenuWidget(
            title: 'Settings',
            icon: Icons.settings,
            textColor: Colors.black,
            endIcon: true,
            onPress: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          ProfileMenuWidget(
            title: 'Update',
            icon: Icons.update,
            textColor: Colors.black,
            endIcon: true,
            onPress: () {},
          ),
          const SizedBox(
            height: 20.0,
          ),
          ProfileMenuWidget(
            title: 'Information',
            icon: Icons.info_rounded,
            textColor: Colors.black,
            endIcon: true,
            onPress: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          ProfileMenuWidget(
            title: 'Logout',
            icon: Icons.logout,
            textColor: Colors.red,
            endIcon: false,
            onPress: () async {
              await _mAuth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProvider()),
                      (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
