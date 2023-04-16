import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onroad/authenticatio/user_or_providr.dart';
import 'package:onroad/mainScreens/main_screens.dart';
import 'dart:io';
import 'package:onroad/user_TabPages/profile/editprofile.dart';
import 'package:onroad/user_TabPages/profile/profile.dart';
import 'package:onroad/user_TabPages/profile/profile_body.dart';


class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  String? name;
  String? image;
  File? _imageFile;

  final _mAuth = FirebaseAuth.instance;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }


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
                builder: (c) => const MainScreen(),
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
              'Ahmed',
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
        children: [
          Info(
            name: 'User Name',
            image: _imageFile != null ? FileImage(_imageFile!) : null,
            Camera: false,
            onPress: _getImage,
          ),
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
            onPress: () {
              _mAuth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const UserProvider(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
