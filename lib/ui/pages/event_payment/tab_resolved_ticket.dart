import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/my_ticket/data_list_my_ticket.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';

class TabResolvedTicket extends StatefulWidget{
  final List<DataListMyTicket> dataListMyTicket;
  final bool hasReachedEnd;
  final ListMyTicketBloc bloc;
  TabResolvedTicket(
      {required this.dataListMyTicket,
        required this.hasReachedEnd,
        required this.bloc});
  @override
  _TabResolvedTicketState createState() => _TabResolvedTicketState();
}
class _TabResolvedTicketState extends State<TabResolvedTicket>{
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
  bool _checkInAtQR(List<DataListMyTicket> data){
    for(var i in data){
      for(var j in i.stringQr){
        if(j.checkInAt != null)
          return true;
      }
    }
    return false;
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
                if(FormatDate.boolCheckEndAt(widget.dataListMyTicket[index].expiredAt )|| _checkInAtQR(widget.dataListMyTicket)){
                  print(_checkInAtQR(widget.dataListMyTicket));
                  return Padding(
                    padding: AppTheme.paddingAllScreen1,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppTheme.radiusCard1))),
                      elevation: 10.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(SlideLeftTransition(page: DetailMyTicketPage(
                            dataListMyTicket: widget.dataListMyTicket[index],
                            index: index,dataTicket: widget.dataListMyTicket[index].dataTicket,
                            dataEvent: widget.dataListMyTicket[index].event,
                            qrString: [],)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Hero(
                                  tag: index,
                                  child:  Container(
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
                                  ),
                                ),
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
                                                  "Vé check: ${data[index].quantities}",
                                                  style: AppTheme.subtitle1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Loại vé: ${data[index].dataTicket.ticketType}",
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
                                                  "Thời gian: ${FormatDate.getDateHour(data[index].expiredAt)}",
                                                  style: AppTheme.subtitle1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                    "Ngày: ${FormatDate.getDateDMY(data[index].expiredAt)}",
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
                                                    'Vi trí: ',
                                                    style: AppTheme.subtitle1,
                                                    maxLines: 1,
                                                  ),
                                                  flex: 2,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '72/6 Bạch Đằng, P.24, Q.Bình Thạnh, TP.HCM',
                                                    style: AppTheme.subtitleBold1,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  flex: 8,
                                                ),
                                              ],
                                            )),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            'Tổng tiền: ${FormatMoney.coverPrice(data[index].quantities * data[index].dataTicket.price)}',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
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
                }else{

                }
            }, childCount: widget.hasReachedEnd ? data.length : data.length + 1))
      ],
    );
  }
}