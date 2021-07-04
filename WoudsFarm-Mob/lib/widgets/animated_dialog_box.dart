import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class animated_dialog_box {

  static Future showInOutDailog({
    required BuildContext context,
    required Widget yourWidget,
    required Widget icon,
    required Widget title,
    required Widget firstButton,

  }) {
    assert(context != null, "context is null!!");
    assert(yourWidget != null, "yourWidget is null!!");
    assert(firstButton != null, "button is null!!");
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.fastOutSlowIn.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                title: title,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon,
                    Container(
                      height: 10,
                    ),
                    yourWidget
                  ],
                ),
                actions: <Widget>[firstButton],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context, pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) { return Container(); },
        );

  }



}