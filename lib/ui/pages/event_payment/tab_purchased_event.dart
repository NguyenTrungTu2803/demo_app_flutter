import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/my_ticket/data_list_my_ticket.dart';
import 'package:flutter_app_beats/other/format_date.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';

class TabPurchasedEvent extends StatefulWidget {
  final List<DataListMyTicket> dataListMyTicket;
  final bool hasReachedEnd;
  final ListMyTicketBloc bloc;
  TabPurchasedEvent(
      {required this.dataListMyTicket,
      required this.hasReachedEnd,
      required this.bloc});

  @override
  _TabPurchasedEventState createState() => _TabPurchasedEventState();
}

class _TabPurchasedEventState extends State<TabPurchasedEvent> {
  ScrollController _scrollController = ScrollController();
  late int page;
  @override
  void initState() {
    page = 1;
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent == currentScroll) {
        page++;
        widget.bloc.add(ListMyTicketFetchEvent(
          page: page,
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var data = widget.dataListMyTicket;
    return CustomScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(
          parent: const AlwaysScrollableScrollPhysics()),
      slivers: [
        CupertinoSliverRefreshControl(
            builder: (_, __, ___, ____, _____) {
              return Container(
                child: Center(
                  child: Platform.isAndroid
                      ? const RefreshProgressIndicator(
                          backgroundColor: AppTheme.white38,
                        )
                      : const CupertinoActivityIndicator(
                          radius: 20,
                        ),
                ),
              );
            },
            refreshTriggerPullDistance: 100.0,
            refreshIndicatorExtent: 60.0,
            onRefresh: () async {
              page = 1;
              await Future.delayed(Duration(seconds: 3));
              if (data.isNotEmpty) {
                //data.clear();
              }
              setState(() {
                widget.bloc.add(ListMyTicketRefreshEvent(page: page));
              });
            }),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          if (index >= data.length) {
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  width: AppTheme.sizeIcon1,
                  height: AppTheme.sizeIcon1,
                  child: Platform.isAndroid
                      ? const CircularProgressIndicator()
                      : const CupertinoActivityIndicator(),
                ),
              ),
            );
          } else
            return Padding(
              padding: AppTheme.paddingAllScreen1,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppTheme.radiusCard1))),
                elevation: 10.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(SlideLeftTransition(
                        page: DetailMyTicketPage(
                          dataListMyTicket: widget.dataListMyTicket[index],
                          index: index,
                      dataTicket: widget.dataListMyTicket[index].dataTicket,
                      dataEvent: widget.dataListMyTicket[index].event,
                      qrString: [],
                    )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child:Hero(tag: index, child:  Container(
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                    NetworkImage(data[index].event.poster),
                                    alignment: Alignment.center)),
                          )),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data[index].event.name,
                                    style: AppTheme.captionBlack1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "S??? l?????ng: ${data[index].quantities}",
                                            style: AppTheme.subtitle1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Lo???i v??: ${data[index].dataTicket.ticketType}",
                                            style: AppTheme.subtitle1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Th???i gian: ${FormatDate.getDateHour(data[index].expiredAt)}",
                                            style: AppTheme.subtitle1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                              "Ng??y: ${FormatDate.getDateDMY(data[index].expiredAt)}",
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTheme.subtitle1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'Vi tr??: ',
                                              style: AppTheme.subtitle1,
                                              maxLines: 1,
                                            ),
                                            flex: 2,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '72/6 B???ch ?????ng, P.24, Q.B??nh Th???nh, TP.HCM',
                                              style: AppTheme.subtitleBold1,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            flex: 8,
                                          ),
                                        ],
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'T???ng ti???n: ${FormatMoney.coverPrice(data[index].quantities * data[index].dataTicket.price)}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: MaterialButton(
                                          elevation: 0.0,
                                          height: 30,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppTheme.radiusAvatar)),
                                          color: Colors.red,
                                          onPressed: () => Navigator.of(context)
                                              .push(SlideLeftTransition(
                                                  page: QrCodePage(
                                                      dataTicket: widget
                                                          .dataListMyTicket[
                                                              index]
                                                          .dataTicket,
                                                      dataEvent: widget
                                                          .dataListMyTicket[
                                                              index]
                                                          .event,
                                                      qrString: data[index]
                                                          .stringQr))),
                                          child: const Text(
                                            'QR code',
                                            style: AppTheme.white10Bold,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          flex: 8,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
        }, childCount: widget.hasReachedEnd ? data.length : data.length + 1))
      ],
    );
  }
}
