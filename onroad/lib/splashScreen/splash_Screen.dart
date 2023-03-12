import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/login_screen.dart';
import 'package:onroad/authenticatio/signup_screen.dart';
import 'package:onroad/global/global.dart';

import '../mainScreens/main_screens.dart';

class MySplasScreen extends StatefulWidget 
{
  const MySplasScreen({super.key});

  @override
  State<MySplasScreen> createState() => _MySplasScreenState();
}


class _MySplasScreenState extends State<MySplasScreen> {


  // startTimer()
  // {
  //   Timer(const Duration(seconds: 0), () async
  //   {
  //     if(await fAuth.currentUser != null)
  //     {
  //       currentFirebaseUser = fAuth.currentUser;
  //       Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
  //     }
  //     else
  //     {
  //       Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
  //     }
  //   });
  // }


  // @override
  // void initState() {
  //   super.initState();
    
  //   startTimer();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(37, 225, 221, 221),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 180.0,
                    fontFamily: 'Brand Bold',
                     color: Color.fromARGB(255, 79, 115, 17),
                  ),
                ),
                const Text(
                  'ON ROAD',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Signatra',
                     color: Colors.grey,
                  ),
                ),
                 const SizedBox(
                  height: 150.0,
                 ),
                Container(
                  height: 50,
                  child: ElevatedButton.icon( 
                    onPressed: ()
                    {
                     Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                    },
                     icon: const Icon(Icons.arrow_right_outlined),
                      
                     label:  const Text(
                      'Start Now',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                     ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 79, 115, 17),
                        padding: const EdgeInsets.symmetric(horizontal: 75.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 6,
                      ),
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