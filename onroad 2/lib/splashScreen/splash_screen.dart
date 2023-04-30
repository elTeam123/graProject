import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onroad/authenticatio/user_or_providr.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/mainScreens/mainScreens_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
dynamic finalEmail;

class MySplasScreen extends StatefulWidget {
  const MySplasScreen({super.key});

  @override
  State<MySplasScreen> createState() => _MySplasScreenState();
}

class _MySplasScreenState extends State<MySplasScreen> {
  startTimer() {}

  @override
  void initState() {
    getValidationData().whenComplete(() async{
      Timer(const Duration(seconds: 1), () async {
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
    });
    super.initState();
  }
  Future getValidationData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedEmail = prefs.getString('email');
    setState(() {
      finalEmail = obtainedEmail!;
    });
    print(finalEmail);

  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////الجزء الخاص بالخروج من التطبيق //////////////////////////
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Are you sure you want to exit?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () => {
                  Navigator.of(context).pop(true),
                  SystemNavigator.pop(),
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      ///////////////////////////////////////////////////////////////////////
      child: Scaffold(
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
      ),
    );
  }
}
