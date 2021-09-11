import 'package:flutter/material.dart';
import 'package:helpinghand/fireBaseUtils/fire_store.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:helpinghand/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseMessaging _messaging;


  @override
  void initState(){
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      showSimpleNotification(
        Text(notification.title, style: TextStyle(fontSize: 16)),
        subtitle: Text(notification.body),
        background: Colors.cyan.shade700,
        duration: Duration(seconds: 5),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider(
              create: (_) => MenuProvider(),
              child: LayoutBuilder(
                builder: (_, BoxConstraints _constraints) {
                  ScreenUtil.init(_constraints);
                  return OverlaySupport.global(child:
                  MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Helping Hand',
                    theme: ThemeData(primarySwatch: Colors.blue,
                        textTheme: TextTheme(button: TextStyle(fontSize: 20.sp))),
                    home: FirebaseAuth.instance.currentUser != null
                        ? ProfileScreen(user: FirebaseAuth.instance.currentUser)
                        : LoginScreen(),
                  ),
                  );
                },
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              ),
          );
        },
    );
  }


  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // For handling the received firebase.notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
        if (notification != null) {
          print(notification.body);
          showSimpleNotification(
            Text(notification.title),
            subtitle: Text(notification.body),
            background: Colors.cyan.shade700,
            duration: Duration(seconds: 5),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      showSimpleNotification(
        Text(notification.title, style: TextStyle(fontSize: 16)),
        subtitle: Text(notification.body),
        background: Colors.cyan.shade700,
        duration: Duration(seconds: 5),
      );
    }
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String title;
  String body;
}