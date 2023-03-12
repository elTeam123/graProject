import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/authenticatio/signup_screen.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/mainScreens/main_screens.dart';
import 'package:onroad/splashScreen/splash_Screen.dart';
import 'package:onroad/widgets/progress_dialog.dart';



class LoginScreen extends StatefulWidget 
{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool pass =true;
  


  validateForm()
  {
    if(!emailController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(passwordController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginDriverNow();
    }
  }

  loginDriverNow() async
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing, Please wait...",);
        }
    );

    final User? firebaseUser = (
        await fAuth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successful.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MainScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during Login.");
    }
  }





  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key:formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      height: 300,
                      width: double.infinity,
                      image: AssetImage(
                        'images/Login.png',
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 55.0,
                      width: 300.0,
                      
                      child: TextFormField(
                        controller: emailController,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
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
                              borderSide:BorderSide(
                                color: Colors.green,
                              )
                          ),
                          focusedBorder:  OutlineInputBorder(

                              borderRadius: BorderRadius.circular(30),
                              borderSide:BorderSide(
                                color: Colors.green,

                              )
                          ),
                        ),

                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
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
                            onPressed: ()
                            {

                              setState(() {
                                pass = !pass;
                              });

                            },
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.green,
                            ),
                          ),

                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(30),
                              borderSide:BorderSide(
                              color: Colors.green,
                              width: 3,
                            )
                          ),
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:BorderSide(
                                color: Colors.green,
                              )
                          ),
                        ),
                      ),
                    ),
                      Container(
                       height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 121),
                          child: TextButton(
                            onPressed: (){},
                            child: Text(
                              'Forgot your password ?',
                              style: TextStyle(
                                color: Colors.red[400],
                                fontSize: 12,
                              ),
                              
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                          255,
                          79,
                          115,
                          17,
                        ),
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                      ),
                      width: 300,
                      height: 55.0,
                      child: MaterialButton(
                        onPressed: ()
                        {

                         validateForm();

                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Dont have an account?'),
                        TextButton(
                          onPressed: () 
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));

                          },
                          child: const Text(
                            'SignUp Here',
                            style:TextStyle(
                              color: Colors.green,
                            ) ,
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