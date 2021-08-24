import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/models/my_ticket/data_event.dart';
import 'package:flutter_app_beats/models/my_ticket/data_list_my_ticket.dart';
import 'package:flutter_app_beats/models/my_ticket/data_ticket.dart';
import 'package:flutter_app_beats/models/my_ticket/string_qr.dart';
import 'package:flutter_app_beats/other/other.dart';

class DetailMyTicketPage extends StatefulWidget {
  final List<StringQr> qrString;
  final DataEvent dataEvent;
  final DataTicket dataTicket;
  final int index;
  final DataListMyTicket dataListMyTicket;

  DetailMyTicketPage(
      {required this.qrString,
      required this.dataEvent,
      required this.dataListMyTicket,
      required this.dataTicket,
      required this.index});

  @override
  _DetailMyTicketPageState createState() => _DetailMyTicketPageState();
}

class _DetailMyTicketPageState extends State<DetailMyTicketPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        centerTitle: true,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppTheme.red,
        title: Text(
          'Chi tiết vé',
          style: AppTheme.titleAppBar1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              child: Container(
                height: width * .5,
                decoration: BoxDecoration(
                    color: AppTheme.white38,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.dataEvent.poster),
                    )),
              ),
              tag: widget.index,
            ),
            Padding(
              padding: AppTheme.paddingLeftRightTopScreen1,
              child: Text(
                widget.dataEvent.name,
                style: AppTheme.title1,
              ),
            ),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(text: 'Địa điểm: ', style: AppTheme.body1),
                      TextSpan(
                          text: 'Nothing here', style: AppTheme.captionBlack1)
                    ]),
                  ),
                )),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Row(children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                            text: 'Mã vé: ', style: AppTheme.body1),
                        TextSpan(
                            text: widget.dataListMyTicket.id.toString(),
                            style: AppTheme.captionBlack1)
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: 'Tổng vé: ', style: AppTheme.body1),
                          TextSpan(
                              text: widget.dataListMyTicket.quantities.toString(),
                              style: AppTheme.captionBlack1)
                        ]),
                      ),
                    ),
                    flex: 1,
                  )
                ])),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(text: 'Loại vé: ', style: AppTheme.body1),
                      TextSpan(
                          text: widget.dataTicket.ticketType,
                          style: AppTheme.captionBlack1)
                    ]),
                  ),
                )),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: 'Thời gian diễn ra: ', style: AppTheme.body1),
                      TextSpan(
                          text: FormatDate.getDateDMYHHMMA(
                              widget.dataEvent.endedAt),
                          style: AppTheme.captionBlack1)
                    ]),
                  ),
                )),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(
                          text: 'Thời gian hết bán vé: ',
                          style: AppTheme.body1),
                      TextSpan(
                          text: FormatDate.getDateDMY(
                              widget.dataListMyTicket.expiredAt),
                          style: AppTheme.captionBlack1)
                    ]),
                  ),
                )),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(text: 'Email: ', style: AppTheme.body1),
                      TextSpan(
                          text: widget.dataListMyTicket.user.email,
                          style: AppTheme.captionBlack1)
                    ]),
                  ),
                )),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Row(
                  children: [
                    Expanded(child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        const TextSpan(
                            text: 'Tổng tiền: ', style: AppTheme.body1),
                        TextSpan(
                            text: FormatMoney.coverPrice(widget.dataTicket.price *
                                widget.dataListMyTicket.quantities),
                            style: AppTheme.captionBlack1)
                      ]),
                    ), flex: 1,),
                    Expanded(child: Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: 'Discount: ', style: AppTheme.body1),
                          TextSpan(
                              text:'${widget.dataListMyTicket.event.discount}%',
                              style: AppTheme.captionBlack1)
                        ]),
                      ),
                    ), flex: 1,),
                  ],
                )),
            Padding(
                padding: AppTheme.paddingLeftRightTopScreen1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(children: <TextSpan>[
                      const TextSpan(text: 'Mô tả: ', style: AppTheme.body1),
                      TextSpan(
                          text: widget.dataTicket.description,
                          style: AppTheme.captionBlack1)
                    ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
