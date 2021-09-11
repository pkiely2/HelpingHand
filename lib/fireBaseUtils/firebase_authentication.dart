import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpinghand/screens/screens.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:helpinghand/widgets/dialogs/dialogs.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<void> signInWithGoogle({bool link = false, AuthCredential authCredential, BuildContext context}) async {

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      auth.signInWithCredential(credential).then((value)
      {
        if(link){
          linkProviders(value, authCredential).then((value) =>
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProfileScreen(user: value.user)))
          });
        }else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfileScreen(user: value.user)));
        }
      }).onError((error, stackTrace) {
        loginException("google", error, auth, context);
      });
    }
  }

  static void loginException(String type, dynamic error, FirebaseAuth auth, BuildContext context) async{
    List<String> types = [];
    if(error.code == 'account-exists-with-different-credential'){
      FirebaseAuth.instance.fetchSignInMethodsForEmail(error.email).then((value) => {
        if (value.contains(value)) {
          types.add("facebook.com"),
          //signInWithGoogle(link: true, authCredential: error.credential, context: context)
        }else if(value.contains("google.com")){
          types.add("google.com"),
          //signInWithFacebook(link: true, authCredential: error.credential, context: context)
        }
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoginExceptionDialog(type: type,logins: types);
        },
      ).then((value){
        if (value == "facebook.com") {
          signInWithGoogle(link: true, authCredential: error.credential, context: context);
        }else if(value == "google.com"){
          signInWithFacebook(link: true, authCredential: error.credential, context: context);
        }
      });
    }else if (error.code == 'invalid-credential') {
      // ...
    }
  }


  static Future<UserCredential> linkProviders(UserCredential userCredential, AuthCredential newCredential) async {
    return await userCredential.user.linkWithCredential(newCredential);
  }


  static Future<UserCredential> signInWithFacebook({bool link = false, AuthCredential authCredential, BuildContext context}) async {
    OAuthCredential facebookAuthCredential;
    try {
      LoginResult loginResult = await FacebookAuth.instance.login();
      facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
      auth.signInWithCredential(facebookAuthCredential).then((value){
        if(link){
          linkProviders(value, authCredential).then((value) => {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen(user: value.user)))
          });
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfileScreen(user: value.user)));
        }
      });
    } on FirebaseAuthException catch (e) {

    } catch (e) {

    }

  }

  static Future<void> signOut({BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    if(googleSignIn != null){
      try {
        if (!kIsWeb) {
          googleSignIn.signOut().then((value) => {
            FirebaseAuth.instance.signOut().then((value) =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()))
            )
          });
        }
      } catch (e) {
      }
    }else{
      FirebaseAuth.instance.signOut().then((value) =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()))
      );
    }


  }

  static String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }


}