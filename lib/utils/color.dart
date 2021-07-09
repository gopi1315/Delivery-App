import 'package:flutter/material.dart';
import 'dart:ui';

final kBackgroundColor = Color.fromRGBO(239, 243, 245, 1.0);
final kPrimaryColor = const Color(0xFF1C75BC);
const kColorLightGrey = Color.fromRGBO(204, 204, 204, 1.0);
const ksecondaryColorThree = Color.fromRGBO(111, 158, 226, 1.0);

final kappbarTitleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamily: "Arboria-Bold");

final kTitleTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: "Arboria-Bold");

final kLabelTextStyleBlack = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: "Arboria-Bold");

final kLabelTextStyleWhite = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontFamily: "Arboria-Bold");

final kLabelTextStyleBlackLight = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w300,
    fontFamily: "Arboria-Light");

final kLabelTextStyleGrayLight = TextStyle(
    fontSize: 15,
    color: Colors.grey,
    fontWeight: FontWeight.w300,
    fontFamily: "Arboria-Light");

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.black,
  minimumSize: Size(100, 36),
  padding: EdgeInsets.symmetric(horizontal: 30),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);