
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({
    super.key,
    required this.name,
    required this.image,
    this.Camera = true,
    required this.onPress,
  });
  var image;
  final String name;
  final bool Camera;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.0,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              color: Colors.green,
              height: 200.0,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      height: 140.0,
                      width: 140.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: image,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Container(
                          height: 40.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Camera
                              ? MaterialButton(
                                  onPressed: onPress,
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                )
                              : null),
                    ),
                  ],
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Brand Bold',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(
      width / 2,
      height,
      width,
      height - 100,
    );
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
