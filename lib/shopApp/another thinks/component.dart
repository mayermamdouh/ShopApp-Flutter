import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



void showToast({
    required String text,
    required ToastStates states,
})=>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0
    );
enum ToastStates{SUCCESS , ERROR , WARNING}

Color? ChooseToastColor(ToastStates states) {
    Color color;
    switch (states) {
        case ToastStates.SUCCESS:
            color = Colors.green;
            break;
        case ToastStates.ERROR:
            color = Colors.red;
            break;
        case ToastStates.WARNING:
            color =  Colors.yellow;
            break;
    }
    return color;
}