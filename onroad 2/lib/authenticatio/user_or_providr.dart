import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/provider/login_screen_provider.dart';
import 'package:onroad/authenticatio/user/signup_user.dart';
import 'package:onroad/authenticatio/user/user_login.dart';
import 'package:onroad/mainScreens/main_screens.dart';


class UserProvider extends StatefulWidget {
  const UserProvider({super.key});

  @override
  State<UserProvider> createState() => _UserProviderState();
}

class _UserProviderState extends State<UserProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //   IconButton(
                //   onPressed: (){},
                //   icon: Icon(
                //   Icons.arrow_left_outlined,
                //   color:Colors.black,
                //   ),
                // ),
                Image.asset('images/1.png'),
                const SizedBox(
                  height: 65.0,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Brand Bold',
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'On Road',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Signatra',
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Center(
                  child: Text(
                    'Login As',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Brand Bold',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 55.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 130,
                                   ///////////////////User push///////////////////////////
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const MainScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 79, 115, 17),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 6,
                        ),
                        child: const Text(
                          'User',
                          style: TextStyle(
                            fontFamily: 'Brand Bold',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      height: 50,
                      width: 130,
                                        ////////////////Provider push //////////////
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const ProviderLoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 79, 115, 17),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 6,
                        ),
                        child: const Text(
                          'Provider',
                          style: TextStyle(
                            fontFamily: 'Brand Bold',
                            fontSize: 15,
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
    );
  }
}
