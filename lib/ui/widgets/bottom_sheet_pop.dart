import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class BottomSheetPop {
  static sharedBottomSheet(BuildContext context, double width, double height, List<String> listIcon, List<String> title, Function function) =>
      showModalBottomSheet(
        shape:const  RoundedRectangleBorder(
            borderRadius:const  BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))
        ),
          context: context, builder: (context) => Container(
        width: width, height: height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))
          ),
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: listIcon.length,
              itemBuilder: (context, index){
            return ListTile(
                onTap: ()=>function(),
              title: Text(title[index]),
              leading: Image.asset(listIcon[index], height: 30, width: 30,fit: BoxFit.contain,),
            );
          }),
      ));
}
