import 'package:flutter/cupertino.dart';
import 'package:flutter_app_beats/config/app_theme.dart';

class TabCompanyInformation extends StatelessWidget{
  final String des;

  TabCompanyInformation({required this.des});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppTheme.paddingAllScreen1,
        child: Column(
          children: [
            Padding(
              padding: AppTheme.paddingBottomCardListViewScreenApp1,
              child: Text(des, style: AppTheme.captionBlack,),
            )
          ],
        ),
      )
    );
  }
}