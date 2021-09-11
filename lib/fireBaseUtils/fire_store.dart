import 'dart:convert';
import 'fire_notifications.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpinghand/widgets/dialogs/dialogs.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('translations');
final CollectionReference _notificationCollection = _firestore.collection('tokens');


class FireStore{

  static Future<void> addToken(String token){
    List<dynamic> tokens = [];
    getTokens().then((value) => {
          tokens = value.docs[0].get("data"),
          if(!tokens.contains(token)){
            tokens.add(token),
            _notificationCollection.doc(value.docs[0].id).update({"data": tokens}),
          },
    });
  }

  static Future<QuerySnapshot> getTokens(){
    return _notificationCollection.get();
  }

  static Future<void> addTranslation(String url, String format, String title, String postedBy, BuildContext context) async {

    _mainCollection.add(add(format, title, postedBy, url)).then((value) => {

        FireBaseNotification.sendNotification("A New $format Has Been Added", "Tittle : $title"),
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBoxState(title: (format == "mp4" ? "Video" : "Text") + "Successfully Uploaded",
                  description: "You're translation has been uploaded and is visible by other users",
                  voidCallback: null);
            })

    }).catchError((e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBoxState(title: "Upload Failed",
                description: "You're translation failed to upload",
                voidCallback: null);
          }
      );
    });
  }

  static Map<String, dynamic> add(String format, String title, String postedBy, String downloadUrl){


    Map<String, dynamic> dets = new Map<String, dynamic>();

    dets.addAll({
      "postedBy": postedBy,
      "timestamp": DateTime.now().toString(),
      "format": format,
      "title": title,
      "responses": 0,
      "response_threads":
      [
        {
          "text": "Hi, can someone please help translating this ? ",
          "timestamp": DateTime.now().toString(),
          "postedBy": postedBy,
          "approved": false,
        }
      ]
    });

    if(format == "mp4"){
      dets.addAll({"download_url": downloadUrl});
    }

    return dets;
  }

  static Future<bool> exists(String title, BuildContext context) async{
    bool exists = false;
    readItems().forEach((element) {
      for (var i = 0; i < element.size; i++) {
        if (element.docs[i]['title'] == title) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBoxState(title: "Translation Exists",
                    description: "The text you're asking to translate already exists !! Click Browse Existing Signs to search for your sign",
                    voidCallback: null);
              }
          );
          exists = true;
        }
      }
    });

    return exists;
  }

  static Future<void> updateThreadApproved(String docId, List<dynamic> threads) async {
    DocumentReference documentReferencer = _mainCollection.doc(docId);
    return documentReferencer.update({"response_threads": threads});
  }

  static Future<void> updateUserName(BuildContext context, String userName) async {
    final QuerySnapshot<Map<String, dynamic>> object = await FirebaseFirestore.instance.collection("translates").get();

    for(var i = 0; i < object.docs.length; i++){
      Map<String, dynamic> data = object.docs[i].data();
      if(data["postedBy"] == FirebaseAuth.instance.currentUser.displayName){
        data["postedBy"] = userName;

        for(var j = 0; j < data["response_threads"].length; j++){
          if(data["response_threads"][j]["postedBy"] == FirebaseAuth.instance.currentUser.displayName){
            data["response_threads"][j]["postedBy"] = userName;
          }
          if(data["response_threads"][j]["approved"]){

          }
          if(data["response_threads"][j]["approval"]["approvedBy"] == FirebaseAuth.instance.currentUser.displayName){
            data["response_threads"][j]["approval"]["approvedBy"] = userName;
          }
        }
        await FirebaseFirestore.instance.collection("translates").doc(object.docs[i].id).update(data);
      }
    }

    await FirebaseAuth.instance.currentUser.updateDisplayName(userName);

  }

  static Future<void> updateThread({String text, String postedBy, String docId, List<dynamic> threads, bool video}) async {

    FireBaseNotification.sendNotification("A New Response Has Been Posted", "Response : $text");

    DocumentReference documentReferencer = _mainCollection.doc(docId);
        threads.add({
          "approved": false,
          (video ? "url" : "text"): text,
          "postedBy": postedBy,
          "timestamp": DateTime.now().toString()
        });

    return documentReferencer.update({"response_threads": threads});
  }

  static Stream<QuerySnapshot> readItems() {
    return _mainCollection.snapshots();
  }


  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}