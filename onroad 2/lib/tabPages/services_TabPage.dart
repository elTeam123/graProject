import 'package:flutter/material.dart';
import 'package:onroad/mainScreens/main_screens.dart';


class ServicesTabPage extends StatefulWidget {
  const ServicesTabPage({super.key});

  @override
  State<ServicesTabPage> createState() => _ServicesTabPageState();
}

class _ServicesTabPageState extends State<ServicesTabPage> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
           Navigator.push(context,MaterialPageRoute( builder: (c) =>  const MainScreen()));
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
            'Services',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Brand Bold',
              color: Colors.black,
            ),
            ),
          ),
        ],
        elevation: 0,
      ),
         body: Stack(
          children: 
          [
           Positioned(
             top: 100,
             width: 360,
             left: 0,
             height: 350,
           child: AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 120),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[190],
              ),
              child:SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: 
                            [
                          Container(
                          decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(20,), 
                          color:Colors.black12 ,
                          ) ,
                          width: 250,
                           height: 80,
                          child:Row(
                          children: 
                          const [
                            Image(
                          height: 60,
                          image: AssetImage(
                          'images/user1.png',
                               ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            'Mohamed Salah',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Brand Bold',
                        
                            ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            '5 Km',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Brand Bold',
                              color: Colors.green,
                        
                            ),
                            ),
                          ],
                             ) ,
                            ),
                             const SizedBox(
                             width: 20,
                              ),
                              const Icon(
                               Icons.line_weight, 
                              color: Color.fromARGB(255, 79, 115, 17),
                              size: 35,
                              
                              )
                            ],
                          ),
                    ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: 
                            [
                          Container(
                          decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(20,), 
                          color:Colors.black12 ,
                          ) ,
                          width: 250,
                           height: 80,
                          child:Row(
                          children: 
                          const [
                            Image(
                          height: 60,
                          image: AssetImage(
                          'images/user1.png',
                               ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            'Mohamed Salah',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Brand Bold',
                        
                            ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            '8 Km',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Brand Bold',
                              color: Colors.green,
                        
                            ),
                            ),
                          ],
                             ) ,
                            ),
                             const SizedBox(
                             width: 20,
                              ),
                              const Icon(
                               Icons.line_weight, 
                              size: 35,
                              
                              )
                            ],
                          ),
                    ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: 
                            [
                          Container(
                          decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(20,), 
                          color:Colors.black12 ,
                          ) ,
                          width: 250,
                           height: 80,
                          child:Row(
                          children: 
                          const [
                            Image(
                          height: 60,
                          image: AssetImage(
                          'images/user1.png',
                               ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            'Mohamed Salah',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Brand Bold',
                        
                            ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            '10 Km',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Brand Bold',
                              color: Colors.green,
                        
                            ),
                            ),
                          ],
                             ) ,
                            ),
                             const SizedBox(
                             width: 20,
                              ),
                              const Icon( 
                               Icons.line_weight, 
                              size: 35,
                              
                              
                              )
                            ],
                          ),
                    ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: 
                            [
                          Container(
                          decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(20,), 
                          color:Colors.black12 ,
                          ) ,
                          width: 250,
                           height: 80,
                          child:Row(
                          children: 
                          const [
                            Image(
                          height: 60,
                          image: AssetImage(
                          'images/user1.png',
                               ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            'Mohamed Salah',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Brand Bold',
                        
                            ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                            '11 Km',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Brand Bold',
                              color: Colors.green,
                        
                            ),
                            ),
                          ],
                             ) ,
                            ),
                             const SizedBox(
                             width: 20,
                              ),
                              const Icon(
                               Icons.line_weight, 
                              size: 35,
                              
                              )
                            ],
                          ),
                    ),
                  ],
                ),
              ) ,
            ),
            ),
          ),
  
        Positioned(
             bottom:0,
             left: 0,
             right: 0,
           child: AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 120),
            child: Container(
              height:300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                 border: Border.all(width: 1.0, color: Colors.black),
                borderRadius:const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft:  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Icon(
                        Icons.linear_scale_sharp,
                        size: 35,
                        color: Colors.grey [400],
                        ),
                      Row(
                      children: 
                      const [
                      Image(
                          height: 60,
                          // width: double.infinity,
                          image: AssetImage(
                          'images/11.jpg',
                          ),
                        ),
                        SizedBox(
                          width: 15,
                          ),
                        Text(
                          'Check out and rescue',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ],
                     ),
                      const Divider(
                      height: 10,
                      ),
                      Row(
                      children: 
                      const [
                           Image(
                          height: 60,
                          // width: double.infinity,
                          image: AssetImage(
                          'images/12.jpg',
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'Tires',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ],
                     ),
                      const Divider(
                      height: 10,
                      ),
                      Row(
                      children: 
                      const [
                           Image(
                          height: 60,
                          // width: double.infinity,
                          image: AssetImage(
                          'images/13.jpg',
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(
                          'The battery',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ],
                     ),
                      const Divider(
                      height: 10,
                      ),
                      Row(
                      children: 
                      const [
                         Image(
                          height: 60,
                          // width: double.infinity,
                          image: AssetImage(
                          'images/10.jpg',
                          ),
                        ),
                        SizedBox(
                          width: 15,
                          
                          ),
                        Text(
                          'Petrol',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brand Bold',
                          ),
                        ),
                      ],
                     )
                    ],
                  ),
                ),
              ),
            ),
            ),
          ),


          ],
         ),
    );
    
  }
}