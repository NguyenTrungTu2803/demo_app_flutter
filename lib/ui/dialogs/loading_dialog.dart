import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog {
  static showLoadingDialog(BuildContext context) => showDialog(
        context: context,
    barrierDismissible: false,
    routeSettings: RouteSettings(arguments: 'showLoadingDialog'),
    barrierColor: Colors.black12,
    builder: (context) =>  Container(
      child: Center(
        child: Platform.isAndroid?  const CircularProgressIndicator() : const CupertinoActivityIndicator(),
      ),
    )
      );
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(showLoadingDialog);
  }
}

