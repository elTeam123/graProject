import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/user_or_providr.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/mainScreens/mainScreens_provider.dart';

class MySplasScreen extends StatefulWidget {
  const MySplasScreen({super.key});

  @override
  State<MySplasScreen> createState() => _MySplasScreenState();
}

class _MySplasScreenState extends State<MySplasScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      if (fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const MainScreenProvider(),
          ),
        );

      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const UserProvider(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(37, 225, 221, 221),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  height: 400,
                  image: AssetImage(
                    'images/onroad.png',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
