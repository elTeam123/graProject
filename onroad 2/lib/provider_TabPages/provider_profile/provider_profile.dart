// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/user_or_providr.dart';
import 'package:onroad/mainScreens/mainScreens_provider.dart';
import 'package:onroad/mainScreens/main_screens.dart';
import 'package:onroad/provider_TabPages/provider_profile/provider_editprofile.dart';
import 'package:onroad/global/profile_icon.dart';
import 'package:onroad/provider_TabPages/provider_profile/provider_info.dart';

class ProviderProfileTabPage extends StatefulWidget {
  const ProviderProfileTabPage({super.key});

  @override
  State<ProviderProfileTabPage> createState() => _ProviderProfileTabPage();
}

class _ProviderProfileTabPage extends State<ProviderProfileTabPage> {
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
                builder: (context) => const MainScreenProvider(),
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
                  builder: (c) => const ProviderEditProfile(),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProviderInfo(),
            const SizedBox(
              height: 50.0,
            ),
            ProfileIcon(
              title: 'Settings',
              icon: Icons.settings,
              textColor: Colors.black,
              endIcon: true,
              onPress: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileIcon(
              title: 'Update',
              icon: Icons.update,
              textColor: Colors.black,
              endIcon: true,
              onPress: () {},
            ),
            const SizedBox(
              height: 20.0,
            ),
            ProfileIcon(
              title: 'Information',
              icon: Icons.info_rounded,
              textColor: Colors.black,
              endIcon: true,
              onPress: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            ProfileIcon(
              title: 'Logout',
              icon: Icons.logout,
              textColor: Colors.red,
              endIcon: false,
              onPress: () async {
                await _mAuth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserProvider(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
