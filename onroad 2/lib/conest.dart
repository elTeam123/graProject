import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

//إنشاء كلاس لتحميل الصور:
class ImageUploader {
  late File file;
  var imagepicker = ImagePicker();
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('images');

  Future<Map<String, dynamic>?> uploadImage() async {
    var imgpicked = await imagepicker.pickImage(source: ImageSource.gallery);

    if (imgpicked != null) {
      file = File(imgpicked.path);
      var nameimage = basename(imgpicked.path);

      // Upload the file to Firebase Storage
      var refstorge = FirebaseStorage.instance.ref("images/$nameimage");
      await refstorge.putFile(file);
      var url = await refstorge.getDownloadURL();

      // Save the name and URL to Firebase Realtime Database
      var key = _databaseRef.push().key;
      _databaseRef.child(key!).set({
        'name': nameimage,
        'url': url,
      });

      return {'name': nameimage, 'url': url};
    } else {
      if (kDebugMode) {
        print('Please choose image');
      }
      return null;
    }
  }
}

// إنشاء واجهة المستخدم (UI) للتفاعل مع الكلاس:
