import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_beats/config/app_theme.dart';

class TabPersonalInformation extends StatelessWidget{
  final String dob;

  TabPersonalInformation({required this.dob});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: Platform.isAndroid ? const ClampingScrollPhysics(): const BouncingScrollPhysics(),
      child: Padding(
        padding: AppTheme.paddingAllScreen1,
        child: Column(
          children: [
            Padding(
              padding: AppTheme.paddingBottomCardListViewScreenApp1,
              child: Row(
                children: [
                  Expanded(child: Text('Số điện thoại: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
                  Expanded(child: Text('', style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
                ],
              ),
            ),
            Padding(
              padding: AppTheme.paddingBottomCardListViewScreenApp1,
              child: Row(
                children: [
                  Expanded(child: Text('Email: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
                  Expanded(child: Text('', style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
                ],
              ),
            ),
        Padding(
          padding: AppTheme.paddingBottomCardListViewScreenApp1,
          child: Row(
            children: [
              Expanded(child: Text('Trình độ học vấn: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
              Expanded(child: Text('', style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
            ],
          ),),
        Padding(
          padding: AppTheme.paddingBottomCardListViewScreenApp1,
          child: Row(
            children: [
              Expanded(child: Text('Ngày sinh: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
              Expanded(child: Text(dob, style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
            ],
          ),),
        Padding(
          padding: AppTheme.paddingBottomCardListViewScreenApp1,
          child: Row(
            children: [
              Expanded(child: Text('Quê quán: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
              Expanded(child: Text('', style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
            ],
          ),),
            Padding(
              padding: AppTheme.paddingBottomCardListViewScreenApp1,
              child: Row(
                children: [
                  Expanded(child: Text('Thể thao: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
                  Expanded(child: Text('', style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
                ],
              ),),
            Padding(
              padding: AppTheme.paddingBottomCardListViewScreenApp1,
              child: Row(
                children: [
                  Expanded(child: Text('Sở thích: ', style: AppTheme.captionBlack,textAlign: TextAlign.start,), flex: 1,),
                  Expanded(child: Text('', style: AppTheme.captionBlack,textAlign: TextAlign.end,), flex: 1,),
                ],
              ),),
          ],
        ),
      )
    );
  }
}