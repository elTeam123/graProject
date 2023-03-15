import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/provider/login_screen_provider.dart';

import 'package:onroad/global/global.dart';
import 'package:onroad/splashScreen/splash_Screen.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}



class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text(
          "Sign Out",
        ),
        onPressed: ()
        {
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
        },
      ),
    );
  }
}