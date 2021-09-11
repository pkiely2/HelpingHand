import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'fire_store.dart';

class FireBaseNotification{
  static void sendNotification(String title, String body) async {
    String token = await FirebaseMessaging.instance.getToken();
    List<String> tokens = [];
    FireStore.getTokens().then((value) => {
        if(token != value.docs[0].get('data')){
          tokens = value.docs[0].get('data'),
        }
    });

    FirebaseMessaging.instance.getToken().then((value) {
      try {
        http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=AAAAWTVDams:APA91bEuW7em1uPbkvx8Kz9i9h3ApwicV1ubWO2X16wzdo0Uvrs74d6olWYwafy1qRewWGY8l5nxvScCP24Sl3fx-gweGQjCViNDz8P-2P32RvabEHMoL-MdnPbOx6fVPJFPNAGSDYqF',
          },
          body: jsonEncode(
            {
              'notification': {
                'body': body,
                'title': title
              },
              "data" : {
                "body": body,
                "title": title
              },
              'registration_ids': [tokens],
            },
          ),
        ).then((value) => {
          print(value.body)
        });
      } catch (e) {
        print(e);
      }
    });

  }
}