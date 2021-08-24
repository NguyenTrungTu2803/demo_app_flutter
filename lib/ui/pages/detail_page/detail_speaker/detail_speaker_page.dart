import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/ui/pages/detail_page/detail_speaker/tab_company_information.dart';
import 'package:flutter_app_beats/ui/pages/detail_page/detail_speaker/tab_personal_information.dart';

class DetailSpeakerPage extends StatelessWidget {
  final String linkAvatar;
  final int index;
  final position;
  final name;
  final dob;
  final description;

  DetailSpeakerPage(
      {required this.linkAvatar,
        required this.index,
        required this.position,
        required this.name,
        required this.description,
        required this.dob});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: LayoutBuilder(builder: (context, snapshot) {
          if (snapshot.maxWidth < 600) {
            return DefaultTabController(
              length: 2,
              child: Column(children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: AppTheme.paddingAllScreen1,
                    child: Card(
                      color: AppTheme.red,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: .5, color: AppTheme.black38),
                        borderRadius: BorderRadius.all(
                          Radius.circular(AppTheme.radiusCard1),
                        ),
                      ),
                      child: Padding(
                        padding: AppTheme.paddingAllScreen1,
                        child: Row(
                          children: [
                            Expanded(
                              child: Hero(
                                tag:index,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: AppTheme.blue, width: 5.0)),
                                    child: Padding(
                                      padding: AppTheme.paddingAllScreen1,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 60.0,
                                        child: CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(linkAvatar),
                                          radius: 53.0,
                                        ),
                                      ),
                                    )),
                              ),
                              flex: 4,
                            ),
                            Expanded(
                              child: Container(
                                height: 150,
                                alignment: Alignment.centerLeft,
                                padding: AppTheme.paddingLeftScreen,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          name,
                                          style: AppTheme.textWhite18Bold1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          position,
                                          style: AppTheme.textStyleWhite1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Chưa cập nhật',
                                        style: AppTheme.textStyleWhite1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppTheme.red,
                    tabs: [
                      Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Image.asset(
                                'assets/icons/ic_infor_person.png',
                                height: AppTheme.sizeIcon1,
                                width: AppTheme.sizeIcon1,
                                fit: BoxFit.cover,
                                color: AppTheme.black,
                              )),
                          Expanded(
                              flex: 1,
                              child: Text(
                                'Thông tin cá nhân',
                                style: AppTheme.captionBlack,
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/ic_infor_company.png',
                            height: AppTheme.sizeIcon1,
                            width: AppTheme.sizeIcon1,
                            fit: BoxFit.cover,
                            color: AppTheme.black,
                          ),
                          Text(
                            'Thông tin công ty',
                            style: AppTheme.captionBlack,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TabBarView(
                    children: [
                      TabPersonalInformation(
                        dob: dob,
                      ),
                      TabCompanyInformation(des: description,),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      elevation: 0.0,
                      height: 200,
                      color: AppTheme.black38,
                      minWidth: width,
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Đóng',
                        style: AppTheme.textWhite18Bold1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ]),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
