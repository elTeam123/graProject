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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        elevation: 5,
        onPressed: () {
          showBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'images/line.jpg',
                        height: 45,
                        color: Colors.grey,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  height: 60,
                                  image: AssetImage(
                                    'images/11.jpg',
                                  ),
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
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  height: 60,
// width: double.infinity,
                                  image: AssetImage(
                                    'images/12.jpg',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Tires',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Brand Bold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  height: 60,
// width: double.infinity,
                                  image: AssetImage(
                                    'images/13.jpg',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'The battery',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Brand Bold',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Image(
                                  height: 60,
// width: double.infinity,
                                  image: AssetImage(
                                    'images/10.jpg',
                                  ),
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
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.miscellaneous_services,
          size: 30,
          color: Colors.black,
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const MainScreen()));
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
      body: Container(
        color: Colors.grey[100],
        child: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: Colors.white,
                            ),
                            width: 250,
                            height: 80,
                            child: Row(
                              children: const [
                                Image(
                                  height: 60,
                                  image: AssetImage(
                                    'images/user.png',
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
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.line_weight,
                              size: 35,
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: Colors.white,
                            ),
                            width: 250,
                            height: 80,
                            child: Row(
                              children: const [
                                Image(
                                  height: 60,
                                  image: AssetImage(
                                    'images/user.png',
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
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.line_weight,
                              size: 35,
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: Colors.white,
                            ),
                            width: 250,
                            height: 80,
                            child: Row(
                              children: const [
                                Image(
                                  height: 60,
                                  image: AssetImage(
                                    'images/user.png',
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
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.line_weight,
                              size: 35,
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              color: Colors.white,
                            ),
                            width: 250,
                            height: 80,
                            child: Row(
                              children: const [
                                Image(
                                  height: 60,
                                  image: AssetImage(
                                    'images/user.png',
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
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.line_weight,
                              size: 35,
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
