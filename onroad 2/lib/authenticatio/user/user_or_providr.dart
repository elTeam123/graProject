import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/provider/signup_screen.dart';
import 'package:onroad/authenticatio/user/user_login.dart';



class UserProvider extends StatefulWidget {
  const UserProvider({super.key});

  @override
  State<UserProvider> createState() => _UserProviderState();
}

class _UserProviderState extends State<UserProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
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
                      'Welcom to',
                       style: TextStyle(
                       fontSize: 40.0,
                       fontFamily:'Brand Bold' ,
                      ),
                     ),
                 ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'On Road',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily:'Signatra' ,
                          color: Colors.grey,
                        ),
                     ),
                  ),
                    const SizedBox(
                    height:30.0 ,
                  ),
                   const Center(
                     child: Text(
                        'Login As',
                         style: TextStyle(
                         fontSize: 30.0,
                         fontFamily:'Brand Bold' ,
                        ),
                       ),
                   ),
                  const SizedBox(
                    height:55.0 ,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: 
                    [
                      Container(
                    height: 50,
                     width: 130,
                    child: ElevatedButton( 
                      onPressed: ()
                      {
                         Navigator.push(context, MaterialPageRoute(builder: (c)=>  LogInPage()));
                       
                      },
                       child: const Text(
                        'User',
                        style: TextStyle(
                          fontFamily: 'Brand Bold',
                          fontSize: 15,
                        ),
                       ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 79, 115, 17),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 6,
                        ),
                        ),
                  ),
                      const SizedBox(
                       width: 20.0,
                      ),
                      Container(
                    height: 50,
                    width: 130,
                    child: ElevatedButton( 
                      onPressed: ()
                      {
                         Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                      },
                       child: const Text(
                        'Service',
                        style: TextStyle(
                          fontFamily: 'Brand Bold',
                          fontSize: 15,
                        ),
                       ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 79, 115, 17),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 6,
                        ),
                        ),
                     ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
  