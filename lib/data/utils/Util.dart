import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeInOut,
        messageColor: Colors.black,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void flushBarSuccessfullMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.greenAccent,
        duration: Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeInOut,
        messageColor: Colors.black,
        flushbarPosition: FlushbarPosition.TOP,
        positionOffset: 20,
        icon: Icon(
          Icons.check,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }
}
