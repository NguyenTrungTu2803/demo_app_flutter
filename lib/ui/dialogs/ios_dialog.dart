import 'package:flutter/cupertino.dart';

class IOSDialog {
  static showDialogCheckIn(BuildContext context, bool content,) =>
      showCupertinoDialog(
        barrierDismissible: false,
          context: context,
          builder: (_) => CupertinoAlertDialog(
                actions: [
                  CupertinoButton(
                      child: Text('Thoát'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
            title: Text('Thông báo'),
            content: content? Text('Check vé thành công'): Text('Check vé không thành công'),
              ),);
  static showDialogLogout(
          BuildContext context, String content, Function function) =>
      showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => CupertinoAlertDialog(
                title: Text("Thông báo"),
                content: Text(content),
                actions: [
                  // Close the dialog
                  CupertinoButton(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  CupertinoButton(
                    child: Text('Logout'),
                    onPressed: () {
                      function();
                    },
                  )
                ],
              ));
}
