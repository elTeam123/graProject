// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onroad/global/global.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  File? _image;
  String? _imageUserUrl;
  bool camera = true;

  Future<void> _getUserImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _uploadUserImage() async {
    if (_image == null) {
      return;
    }
    final ref =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');
    await ref.putFile(_image!);
    final url = await ref.getDownloadURL();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('image_url', url);
    setState(() {
      _imageUserUrl = url;
    });
    final user = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(currentFirebaseUser!.uid);
    user.push().set({
      '_imageUserUrl': _imageUserUrl,
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserImageUrl();
  }

  Future<void> _loadUserImageUrl() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    setState(() {
      _imageUserUrl = user.getString('image_url');
    });
  }

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
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return PhotoViewGallery(
                                pageOptions: [
                                  PhotoViewGalleryPageOptions(
                                    imageProvider: _imageUserUrl != null
                                        ? CachedNetworkImageProvider(_imageUserUrl!)
                                        : null,
                                    heroAttributes:
                                        const PhotoViewHeroAttributes(
                                      tag: "hero",
                                    ),
                                  ),
                                ],
                                loadingBuilder: (context, event) =>
                                    const Center(
                                      child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: _imageUserUrl != null
                              ? CachedNetworkImageProvider(_imageUserUrl!)
                              : null,
                          foregroundImage: _imageUserUrl != null
                              ? null
                              : const AssetImage('images/profile.png'),
                          backgroundColor: Colors.white,
                        ),
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
                        child: camera
                            ? MaterialButton(
                                onPressed: () {
                                  _getUserImage().then((value) => {
                                        setState(() {
                                          camera = false;
                                        })
                                      });
                                },
                                child: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              )
                            : MaterialButton(
                                onPressed: () {
                                  _uploadUserImage().then((value) => {
                                        setState(() {
                                          camera = true;
                                        })
                                      });
                                },
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Full Name',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Brand Bold',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Phone',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Brand Bold',
                    fontWeight: FontWeight.w200,
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
