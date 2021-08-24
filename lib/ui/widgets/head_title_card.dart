import 'package:flutter/cupertino.dart';
import 'package:flutter_app_beats/config/app_theme.dart';

class HeadTitleCard {

  static headTitleCard(List<String> title) => LayoutBuilder(builder: (context, cons){
    if(cons.maxWidth < 600){
      return Container(
          height: AppTheme.heightHeadCard1,
          decoration: BoxDecoration(
              color: AppTheme.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.radiusCard1),
                  topRight: Radius.circular(AppTheme.radiusCard1))),
          child: Row(
              children: title
                  .map((e) => Expanded(
                  child: Text(
                    e.toUpperCase(),
                    style: AppTheme.textWhite18Bold1,
                    textAlign: TextAlign.center,
                  ),
                  flex: 1))
                  .toList()));
    }else{
      return Container(
          height: AppTheme.heightHeadCard2,
          decoration: BoxDecoration(
              color: AppTheme.red,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.radiusCard1),
                  topRight: Radius.circular(AppTheme.radiusCard1))),
          child: Row(
              children: title
                  .map((e) => Expanded(
                  child: Text(
                    e.toUpperCase(),
                    style: AppTheme.textWhite30Bold2,
                    textAlign: TextAlign.center,
                  ),
                  flex: 1))
                  .toList()));
    }
  });
}
