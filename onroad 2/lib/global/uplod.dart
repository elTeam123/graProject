   
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

   late File file;
  var imagepicker = ImagePicker();
   
   uploadImages()async{
     var imgpicked = await imagepicker.pickImage(source: ImageSource.gallery);
     
     if (imgpicked != null) 
     {
        file = File(imgpicked.path);
        var nameimage = basename(imgpicked.path);
      //  start
        var refstorge = FirebaseStorage.instance.ref("images/$nameimage");
        await refstorge.putFile(file);
        var url = refstorge.getDownloadURL();
        if (kDebugMode) {
          print("url : $url");
        }
        return url ;
      //  end

     }else
     {

      if (kDebugMode) {
        print('Please choose image');
      }
     }
   
   }




