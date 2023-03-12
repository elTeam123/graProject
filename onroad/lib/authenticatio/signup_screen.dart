import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:onroad/authenticatio/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/global/global.dart';
import 'package:onroad/global/uplod.dart';
import 'package:onroad/mainScreens/main_screens.dart';
import 'package:onroad/widgets/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool pass = true;

  
  validateForm()
  {
    if(nameController.text.length < 3)
    {
      Fluttertoast.showToast(msg: "name must be atleast 3 Characters.");
    }
    else if(!emailController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email address is not Valid.");
    }
    else if(phoneController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Phone Number is required.");
    }
    else if(passwordController.text.length < 6)
    {
      Fluttertoast.showToast(msg: "Password must be atleast 6 Characters.");
    }
    else
    {
       saveDriverInfoNow();
    }
  }


  saveDriverInfoNow() async
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
      await fAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ).catchError((msg){
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      })
    ).user;

    if(firebaseUser != null)
    {
      Map driverMap =
      {
        "id": firebaseUser.uid,
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim(),
      };

      DatabaseReference driversRef = FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> MainScreen()));
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created.");
    }
  }





  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          15.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Image(
                  height: 300.0,
                  width: double.infinity,
                  image: AssetImage(
                    'images/signup.png',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(

                  height: 55.0,
                  width: 300.0,

                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: ( const TextStyle(
                        fontFamily: 'Brand Bold',
                        color: Colors.green,
                      )),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(30),
                          borderSide:BorderSide(
                            color: Colors.green,

                          )
                      ),
                         focusedBorder:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:BorderSide(
                                color: Colors.green,

                              )
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 55.0,
                  width: 300.0,

                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
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
                  height: 15.0,
                ),
                Container(
                  height: 55.0,
                  width: 300.0,

                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone must not be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: (const TextStyle(
                        fontFamily: 'Brand Bold',
                        color: Colors.green,
                      )),
                      prefixIcon: const Icon(
                        Icons.phone,
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
                  height: 10.0,
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
                        onPressed: () {
                          setState(() {
                            pass = !pass;
                          });
                        },
                        icon: const Icon(
                          Icons.visibility,
                          color: Colors.green,
                        ),
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
                  height: 10.0,
                ),
                  Container(
                  height: 50,
                  width: 300,
                  child: ElevatedButton.icon( 
                    onPressed: ()
                    {
                      uploadImages();
                    },
                     icon: const Icon(Icons.add_a_photo_outlined),
                      
                     label:  const Text(
                      'Card Image',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                     ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Colors.grey[400],
                        // padding: const EdgeInsets.symmetric(horizontal: 75.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 1,
                      ),
                      ),
                ),
                  const SizedBox(
                  height: 15.0,
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
                  height: 55.0,
                  width: 300.0,
                  child: MaterialButton(
                    onPressed: () 
                    {

                      validateForm();

                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontFamily: 'Brand Bold',
                      ),
                    ),
                  ),
                ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Do you have an account ?'),
                        TextButton(
                          onPressed: () 
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));

                          },
                          child: const Text(
                            'Login Here',
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
    );
  }
}