import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';

class BookTicketDialog {
  static showDialogTimeBookTicket(BuildContext context) => showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Text(
                'Thời gian dữ vé của bạn đã hết hiệu lực',
                style: TextStyle(color: Colors.black, fontSize: 12.0),
              ),
            ),
            backgroundColor: Colors.white,
            title: Container(
              child: Text(
                'Hết thời gian',
                textAlign: TextAlign.center,
              ),
            ),
            elevation: 2.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(eventPage, (route) => false);
                    //Navigator.of(context).pop();
                  },
                  child: Text(
                    "Exit",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ))
            ],
          ));
}
