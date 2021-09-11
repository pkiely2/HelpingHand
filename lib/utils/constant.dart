import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Colors
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);
final kFaceBookColor = Color(0xFF102397);
final kGoogleColor = Color(0xFFff4f38);
final kAppPrimaryColor = Colors.grey.shade200;
final kWhite = Colors.white;
final kLightBlack = Colors.black.withOpacity(0.075);
final mCC = Colors.green.withOpacity(0.65);
final fCL = Colors.grey.shade600;
final double padding =20;
final double avatarRadius =45;
bool _dark = false;


const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);

const kSpacingUnit = 10;

BoxDecoration avatarDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: kAppPrimaryColor,

);

