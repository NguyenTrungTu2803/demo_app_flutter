import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/models/my_ticket/data_event.dart';
import 'package:flutter_app_beats/models/my_ticket/data_ticket.dart';
import 'package:flutter_app_beats/models/my_ticket/string_qr.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class QrCodePage extends StatefulWidget {
  final List<StringQr> qrString;
  final DataEvent dataEvent;
  final DataTicket dataTicket;
  QrCodePage(
      {required this.qrString,
      required this.dataEvent,
      required this.dataTicket});

  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  PageController _pageController = PageController();
  bool _isActive = false;
  late List<bool> _listBool;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _listBool = List.filled(widget.qrString.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.red,
        elevation: 5.0,
        title: Text('Qr code vé'),
        centerTitle: true,
        backwardsCompatibility: false,
        titleTextStyle: AppTheme.titleAppBar1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppTheme.red,
            statusBarIconBrightness: Brightness.light),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: AppTheme.paddingAllScreen1,
            child: Column(
              children: [
                Container(
                  color: AppTheme.white70,
                  height: 300,
                  child: PageView(
                    onPageChanged: (index) {},
                    controller: _pageController,
                    children: widget.qrString
                        .map((e) => Center(
                      child: QrImage(
                        data: e.qr,
                      ),
                    ))
                        .toList(),
                  ),
                ),
                Container(
                  padding: AppTheme.paddingTopScreen,
                  child: Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.qrString.length,
                        effect: WormEffect(
                            dotColor: AppTheme.white70,
                            spacing: 2.0,
                            dotHeight: 15,
                            dotWidth: _isActive ? 15 : 15,
                            radius: 10,
                            activeDotColor: AppTheme.black80,
                            strokeWidth: 5.0),
                        onDotClicked: (index) => _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInCubic),
                      )),
                ),
                Padding(
                  padding: AppTheme.paddingTopScreen,
                  child: Text(
                    widget.dataEvent.name,
                    style: AppTheme.title1,
                  ),
                ),
                Padding(
                  padding: AppTheme.paddingTopScreen,
                  child: Row(
                    children: [
                      Expanded(child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: 'Giá :',
                              style: AppTheme.body1
                          ),
                          TextSpan(
                              text:
                              ' ${FormatMoney.coverPrice(widget.dataTicket.price)}/vé',
                              style: AppTheme.captionBlack1
                          )
                        ]),
                      ), flex: 1,),
                      Expanded(child: RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(text:'Loại vé: ', style: AppTheme.body1),
                                TextSpan(text: widget.dataTicket.ticketType, style: AppTheme.captionBlack1)
                              ]
                          )), flex: 1,)
                    ],
                  ),
                ),
               Padding(
                 padding: AppTheme.paddingTopScreen,
                 child:  Align(
                   alignment: Alignment.centerLeft,
                   child: RichText(
                     textAlign: TextAlign.right,
                     text: TextSpan(children: <TextSpan>[
                       const TextSpan(
                           text: 'Thời gian diễn ra :',
                           style: AppTheme.body1
                       ),
                       TextSpan(
                           text:
                           ' ${FormatDate.getDateDMYHHMMA(widget.dataEvent.endedAt)}',
                           style: AppTheme.captionBlack1)
                     ]),
                   ),
                 ),
               ),

                Padding(
                  padding: AppTheme.paddingTopScreen,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'Địa điểm: ', style: AppTheme.body1),
                          const TextSpan(text: ' Nothing here' ,style: AppTheme.captionBlack1)
                        ]
                    ),),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
