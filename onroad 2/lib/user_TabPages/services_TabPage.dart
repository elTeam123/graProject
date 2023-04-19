import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onroad/global/global.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

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
            SystemNavigator.pop();
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
      body: SafeArea(
        child: SlidingUpPanel(
          maxHeight: 400,
          minHeight: 50,
          panel: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'images/line.png',
                    height: 45,
                    color: Colors.grey,
                  ),
                  MaterialButton(
                    onPressed: () {},
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
                                'images/11.png',
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
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {},
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
                                'images/12.png',
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
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {},
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
                                'images/13.png',
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
                    height: 16,
                  ),
                  MaterialButton(
                    onPressed: () {},
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
                                'images/10.png',
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
          ),
          body: ListView.builder(
              itemCount: dList.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    20,
                                  ),
                                  color: Colors.white,
                                ),
                                width: 250,
                                height: 80,
                                child: Row(
                                  children: [
                                    const Image(
                                      height: 60,
                                      image: AssetImage(
                                        'images/user.png',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      dList[index]['fname'] +
                                          " " +
                                          dList[index]['lname'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Brand Bold',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
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
                            ),
                            SmoothStarRating(
                              rating: 3.5,
                              color: Colors.black,
                              borderColor: Colors.white70,
                              allowHalfRating: true,
                              starCount: 5,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              }),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
      ),
    );
  }
}
