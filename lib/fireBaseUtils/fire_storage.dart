import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'fire_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;



class FireStorage{
  static uploadVideo(String filePath, BuildContext context) async {
    File file = File(filePath);
    try {
      await
      firebase_storage.
      FirebaseStorage.
      instance.
      ref('videos/' + filePath).
      putFile(file).
      whenComplete(() => {
        firebase_storage.FirebaseStorage.instance
          .ref('videos/'+filePath)
          .getDownloadURL().then((value) => {
            FireStore.addTranslation(value, "mp4", "Video Translation", FirebaseAuth.instance.currentUser.displayName, context)
          })
      });
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  static uploadVideoResponse(String filePath, String postedBy, String docId, List<dynamic> threads, BuildContext context) async {
    File file = File(filePath);
    try {
      await
      firebase_storage.
      FirebaseStorage.
      instance.
      ref('videos/' + filePath).
      putFile(file).
      whenComplete(() => {
        firebase_storage.FirebaseStorage.instance
            .ref('videos/'+filePath)
            .getDownloadURL().then((value) => {
          FireStore.updateThread(
              text: value,
              postedBy: postedBy,
              docId: docId,
              threads: threads,
              video: true
          )
              .whenComplete(() =>
          {
            Fluttertoast.showToast(
                msg: "Sent",
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blueAccent,
                textColor: Colors.white,
                fontSize: 16.0
            )
          })
              .onError((error, stackTrace) => null)
        })
      });
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
  }
}