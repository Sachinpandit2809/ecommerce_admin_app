import 'dart:io';

import 'package:ecommerce_admin_app/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageServices {
  final FirebaseStorage _storage = FirebaseStorage.instance;

// TO  UPLOAD IMAGE TO THE FIREBASE STORAGE
  Future<String?> uploadImage(String path, BuildContext context) async {
    Utils.toastSuccessMessage("Uploading Image...");
    File file  = File(path);
    try{
      //CREATE A UNIQUE FILE NAME BASED ON THE CURRENT TIME 
      String fileName = DateTime.now().toString();

      // CREATE A REFERENCE TO FIREBASE STORAGE 
      Reference ref = _storage.ref().child("shop_images/$fileName");

      //UPLOAD THE FILE 
      UploadTask uploadTask = ref.putFile(file);

      // WAITING FOR THE UPLOAD TI COMPLETE 
      await uploadTask;

      // GET THE DOWNLOAD URL 
      String downloadURl = await ref.getDownloadURL();
      debugPrint("DOWNLOAD URL :=> $downloadURl");
      return downloadURl;
    } catch (e){
      debugPrint("ERROR IN UPLOAD IMAGE:=> $e");
      return null;


    }
  }
}
