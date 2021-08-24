import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasePopDialog {
  static showDialogPop(BuildContext context, String title, String content) => showDialog(context: context,
    barrierDismissible: false,
    builder: (context)=> AlertDialog(
      content: Container(
        child: Text(content, style: TextStyle(color: Colors.black, fontSize: 12.0),),
      ),
      backgroundColor: Colors.white,
      title: Container(
        child: Text(title,textAlign:TextAlign.center,),
      ),
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      titleTextStyle:const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20.0, ),
      actions: [
        TextButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Dismiss", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),))
      ],
    )
  );
}