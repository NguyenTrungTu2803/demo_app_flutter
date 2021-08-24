import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/detail/data_tickets.dart';
import 'package:flutter_app_beats/other/format_money.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/fetch_ticket.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/ticket_type_model.dart';
import 'package:flutter_app_beats/ui/widgets/head_title_card.dart';
import 'package:flutter_app_beats/ui/widgets/ticket_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketType extends StatefulWidget {
  final int id;
  final String hostedAt;
  final String endedAt;
  final List<DataTickets> listTickets;
  final SumCallback sumCallback;
  final ListFetchCounterTicket listFetchCounterTicket;
  TicketType(
      {required this.listTickets,
        required this.sumCallback,
        required this.hostedAt,
        required this.endedAt,
        required this.id,
        required this.listFetchCounterTicket});

  @override
  _TicketTypeState createState() => _TicketTypeState();
}

typedef void SumCallback(TicketTypeModel sum);
typedef void ListFetchCounterTicket(List<FetchTicket> list);

class _TicketTypeState extends State<TicketType> {
  late List<int> counter;
  late List<int> _sumTicket;
  late DetailEventBloc _detailEventBloc;
  List<DataTickets> listTicket = [];
  List<FetchTicket> listFetchTicket = [];
  @override
  void initState() {
    if (widget.listTickets.isNotEmpty) {
      _sumTicket = List.filled(widget.listTickets.length, 0);
      counter = List.filled(widget.listTickets.length , 0);
      listFetchTicket = List.generate(widget.listTickets.length,
          (index) => FetchTicket(widget.listTickets[index].id, counter[index]));
    } else {
      _detailEventBloc = BlocProvider.of<DetailEventBloc>(context);
      _detailEventBloc.add(DetailStartEvent(id: widget.id));
      setState(() {
        _sumTicket = List.filled(5, 0);
        counter = List.filled(5 , 0);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: AppTheme.paddingLeftRightTopScreen1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Card(
                elevation: 2.0,
                shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppTheme.radiusCard1)),
                    side: const BorderSide(color: AppTheme.black38, width: .5)),
                child: widget.listTickets.isNotEmpty
                    ? Column(
                        children: <Widget>[
                          HeadTitleCard.headTitleCard(
                              ['chọn loại vé', 'số lượng vé']),
                          Column(
                              children: widget.listTickets
                                  .map((e) => Padding(
                                            padding: AppTheme.paddingAllScreen1,
                                            child:Row(
                                              children: [
                                                Expanded(child: Container(
                                                  height: AppTheme.heightButton1,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      const BorderRadius
                                                          .all(const Radius
                                                          .circular(
                                                          AppTheme
                                                              .radiusAvatar)),
                                                      border: Border.all(
                                                          color: AppTheme.black70)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(
                                                          padding: AppTheme
                                                              .paddingLeftRightScreenApp1,
                                                          child: Text(
                                                              "${e.ticketType}"
                                                                  .toUpperCase(),
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              style: AppTheme
                                                                  .captionBlack),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: IconButton(
                                                          alignment: Alignment.center,
                                                            onPressed: () {
                                                              Navigator.of(context).push(
                                                                  HelpTicketDialog(
                                                                    barrier: true,
                                                                      builder:
                                                                          (context) =>
                                                                          TicketDescription(
                                                                            e.ticketType,
                                                                            e.description,
                                                                          )));
                                                            },
                                                            icon: const Align(
                                                              alignment:
                                                              Alignment.center,
                                                              child: const Icon(
                                                                Icons.help_outline,
                                                                color: AppTheme
                                                                    .black38,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ), flex:5,),
                                                Expanded(child: SizedBox(), flex: 1,),
                                                Expanded(child: Container(
                                                  height: AppTheme.heightButton1,
                                                                        alignment: Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                            const BorderRadius.all(
                                                                                Radius.circular(
                                                                                    AppTheme.radiusAvatar)),
                                                                            border: Border.all(
                                                                                color:
                                                                                AppTheme.black70)),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: Container(
                                                                                  child: IconButton(
                                                                                    onPressed: () {
                                                                                      counter[widget.listTickets.indexOf(e)]--;
                                                                                      if (counter[widget.listTickets.indexOf(e)] <
                                                                                          0) {
                                                                                        counter[widget.listTickets.indexOf(e)] =
                                                                                        0;
                                                                                      }
                                                                                      _sumTicket[
                                                                                      widget.listTickets.indexOf(e)] = counter[
                                                                                      widget.listTickets.indexOf(e)] *
                                                                                          widget
                                                                                              .listTickets[
                                                                                          widget.listTickets.indexOf(e)]
                                                                                              .price;
                                                                                      checkCount();
                                                                                      listFetchTicket[widget.listTickets.indexOf(e)].totalTicket = counter[widget.listTickets.indexOf(e)];
                                                                                      BuyTicketPage.of(context)!.listFetchCounterTicket = listFetchTicket;
                                                                                      setState(() {
                                                                                      });
                                                                                    },
                                                                                    icon: const Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: const Icon(
                                                                                          Icons.remove_outlined),
                                                                                    ),
                                                                                    color:
                                                                                   AppTheme.black70,
                                                                                  )),
                                                                              flex: 1,
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                alignment:
                                                                                Alignment.center,
                                                                                width: width * .15,
                                                                                height: width * .1,
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                    left: BorderSide(width: 1.5, color: Colors.black26),
                                                                                    right: BorderSide(width: 1.5, color: Colors.black26),
                                                                                  ),),
                                                                                child: Text(
                                                                                  counter[widget.listTickets.indexOf(e)]
                                                                                      .toString(),
                                                                                  style: TextStyle(
                                                                                    color: Colors.black,
                                                                                    fontSize: 12,
                                                                                    fontWeight:
                                                                                    FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              flex: 1,
                                                                            ),
                                                                            Expanded(
                                                                              child: SizedBox(
                                                                                child: IconButton(
                                                                                  icon: const Icon(
                                                                                      Icons.add),
                                                                                  color:
                                                                                  AppTheme.black70,
                                                                                  onPressed: () {
                                                                                    counter[widget.listTickets.indexOf(e)]++;
                                                                                    if(counter[widget.listTickets.indexOf(e)] > e.quantities){
                                                                                      counter[widget.listTickets.indexOf(e)] = e.quantities;
                                                                                    }
                                                                                    else if (counter[widget.listTickets.indexOf(e)] > 10 && counter[widget.listTickets.indexOf(e)] <= e.quantities ) {
                                                                                      counter[widget.listTickets.indexOf(e)] = 10;
                                                                                    }
                                                                                    _sumTicket[
                                                                                    widget.listTickets.indexOf(e)] = counter[
                                                                                    widget.listTickets.indexOf(e)] * widget.listTickets[widget.listTickets.indexOf(e)].price;
                                                                                    checkCount();
                                                                                    listFetchTicket[widget.listTickets.indexOf(e)].totalTicket = counter[widget.listTickets.indexOf(e)];

                                                                                    BuyTicketPage.of(context)!.listFetchCounterTicket = listFetchTicket;
                                                                                    setState(() {
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              flex: 1,
                                                                            ),
                                                                          ],
                                                                        )),
                                                                    flex: 4,
                                                                  ),
                                              ],
                                            ),
                                          )


                                      )
                                  .toList(),
                            ),
                          Container(
                            // alignment: Alignment.center,
                            height: 100,
                            padding: AppTheme.paddingLeftRightScreenApp1,
                            decoration: const BoxDecoration(
                                border: const Border(
                                    top: const BorderSide(
                                        color: Colors.black26, width: .5))),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "(Bán từ ${FormatDate.getDateMonthDay(widget.hostedAt, widget.endedAt)})",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Text(
                                      "Tổng tiền: ${FormatMoney.coverPrice(sumTickets(_sumTicket))} ",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : BlocBuilder<DetailEventBloc, DetailState>(
                        builder: (context, state) {
                          if(state is DetailStateFetched){
                            return Column(
                              children: <Widget>[
                                HeadTitleCard.headTitleCard(
                                    ['chọn loại vé', 'số lượng vé']),
                                  Column(
                                    children: List.filled(5, true).map((e) =>Padding(
                                      padding: AppTheme.paddingAllScreen1,
                                      child:Row(
                                        children: [
                                          Expanded(child: Container(
                                            height: AppTheme.heightButton1,
                                            decoration: BoxDecoration(
                                              color: AppTheme.white38,
                                                borderRadius:
                                                const BorderRadius
                                                    .all(const Radius
                                                    .circular(
                                                    AppTheme
                                                        .radiusAvatar)),
                                                border: Border.all(
                                                    color: AppTheme.white38)),
                                          ), flex:5,),
                                          Expanded(child: SizedBox(), flex: 1,),
                                          Expanded(child: Container(
                                              height: AppTheme.heightButton1,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppTheme.white38,
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          AppTheme.radiusAvatar)),
                                                  border: Border.all(
                                                      color:
                                                      AppTheme.white38))),
                                            flex: 4,
                                          ),
                                        ],
                                      ),
                                    )).toList(),
                                  ),
                                Container(
                                  height: 100,
                                  padding: AppTheme.paddingLeftRightScreenApp1,
                                  decoration: const BoxDecoration(
                                      border: const Border(
                                          top: const BorderSide(
                                              color: Colors.black38,
                                              width: .5))),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: ColoredBox(color: AppTheme.white70,),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: ColoredBox(color: AppTheme.white70,),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            );
                          }
                        else if (state is DetailStateSuccess) {
                          listTicket = state.eventModel.listTickets;
                          listFetchTicket = List.generate(
                              listTicket.length,
                              (index) => FetchTicket(
                                  listTicket[index].id, counter[index]));
                          return Column(
                              children: <Widget>[
                                HeadTitleCard.headTitleCard(
                                    ['chọn loại vé', 'số lượng vé']),
                                if (listTicket != null)
                                  Column(
                                    children: listTicket.map((e) =>Padding(
                                      padding: AppTheme.paddingAllScreen1,
                                      child:Row(
                                        children: [
                                          Expanded(child: Container(
                                            height: AppTheme.heightButton1,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius
                                                    .all(const Radius
                                                    .circular(
                                                    AppTheme
                                                        .radiusAvatar)),
                                                border: Border.all(
                                                    color: AppTheme.black70)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: AppTheme
                                                        .paddingLeftRightScreenApp1,
                                                    child: Text(
                                                        "${e.ticketType}"
                                                            .toUpperCase(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: AppTheme
                                                            .captionBlack),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: IconButton(
                                                      alignment: Alignment.center,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            HelpTicketDialog(
                                                              barrier: true,
                                                                builder:
                                                                    (context) =>
                                                                    TicketDescription(
                                                                      e.ticketType,
                                                                      e.description,
                                                                    )));
                                                      },
                                                      icon: const Align(
                                                        alignment:
                                                        Alignment.center,
                                                        child: const Icon(
                                                          Icons.help_outline,
                                                          color: AppTheme
                                                              .black38,
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ), flex:5,),
                                          Expanded(child: SizedBox(), flex: 1,),
                                          Expanded(child: Container(
                                              height: AppTheme.heightButton1,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(
                                                          AppTheme.radiusAvatar)),
                                                  border: Border.all(
                                                      color:
                                                      AppTheme.black70)),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            counter[listTicket.indexOf(e)]--;
                                                            if (counter[listTicket.indexOf(e)] <
                                                                0) {
                                                              counter[listTicket.indexOf(e)] =
                                                              0;
                                                            }
                                                            _sumTicket[
                                                            listTicket.indexOf(e)] = counter[
                                                            listTicket.indexOf(e)] *
                                                                listTicket[
                                                                listTicket.indexOf(e)]
                                                                    .price;
                                                            checkCount();
                                                            listFetchTicket[listTicket.indexOf(e)].totalTicket = counter[listTicket.indexOf(e)];
                                                            BuyTicketPage.of(context)!.listFetchCounterTicket = listFetchTicket;
                                                            setState(() {
                                                            });
                                                          },
                                                          icon: const Align(
                                                            alignment: Alignment.center,
                                                            child: const Icon(
                                                                Icons.remove_outlined),
                                                          ),
                                                          color:
                                                          AppTheme.black70,
                                                        )),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      alignment:
                                                      Alignment.center,
                                                      width: width * .15,
                                                      height: width * .1,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          left: BorderSide(width: 1.5, color: Colors.black26),
                                                          right: BorderSide(width: 1.5, color: Colors.black26),
                                                        ),),
                                                      child: Text(
                                                        counter[listTicket.indexOf(e)]
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.add),
                                                        color:
                                                        AppTheme.black70,
                                                        onPressed: () {
                                                          counter[listTicket.indexOf(e)]++;
                                                          if(counter[listTicket.indexOf(e)] > e.quantities){
                                                            counter[listTicket.indexOf(e)] = e.quantities;
                                                          }
                                                          else if (counter[listTicket.indexOf(e)] > 10 ) {
                                                            counter[listTicket.indexOf(e)] = 10;
                                                          }
                                                          _sumTicket[
                                                          listTicket.indexOf(e)] = counter[
                                                          listTicket.indexOf(e)] *
                                                          listTicket[
                                                          listTicket.indexOf(e)]
                                                                  .price;
                                                          checkCount();
                                                          listFetchTicket[listTicket.indexOf(e)].totalTicket = counter[listTicket.indexOf(e)];
                                                          BuyTicketPage.of(context)!.listFetchCounterTicket = listFetchTicket;
                                                          setState(() {
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                ],
                                              )),
                                            flex: 4,
                                          ),
                                        ],
                                      ),
                                    )).toList(),
                                  ),
                                Container(
                                    height: 100,
                                    padding: AppTheme.paddingLeftRightScreenApp1,
                                    decoration: const BoxDecoration(
                                        border: const Border(
                                            top: const BorderSide(
                                                color: Colors.black38,
                                                width: .5))),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            "(Bán từ ${FormatDate.getDateMonthDay(widget.hostedAt, widget.endedAt)})",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Text(
                                              "Tổng tiền: ${FormatMoney.coverPrice(sumTickets(_sumTicket))} ",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),

                              ],
                            );
                        } else {
                          return SizedBox(
                            height: 50,
                          );
                        }
                      }));
          } else {
            return Card(
                elevation: 2.0,
                shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    side: const BorderSide(color: Colors.blueGrey, width: .5)),
                child: widget.listTickets != null
                    ? Container(
                        height:
                            width / 5 * widget.listTickets.length.toDouble(),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    const Text(
                                      'CHỌN LOẠI VÉ',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'SỐ LƯƠNG VÉ',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              flex: 1,
                            ),
                            if (widget.listTickets != null)
                              Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                        padding: EdgeInsets.only(
                                            top: width * .04,
                                            left: width * .02,
                                            right: width * .02),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                      height: width * .1,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      AppTheme
                                                                          .radiusAvatar)),
                                                          border: Border.all(
                                                              color: AppTheme
                                                                  .black70)),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    width * .07,
                                                                right: width *
                                                                    .07),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                "${widget.listTickets[index].ticketType}"
                                                                    .toUpperCase(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(HelpTicketDialog(
                                                                    barrier: true,
                                                                          builder: (context) => TicketDescription(
                                                                                widget.listTickets[index].ticketType,
                                                                                widget.listTickets[index].description,
                                                                              )));
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .help_outline,
                                                                  size: width *
                                                                      .05,
                                                                  color: Colors
                                                                      .black26,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                  flex: 8,
                                                ),
                                                Expanded(
                                                  child: const SizedBox(),
                                                  flex: 1,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                      height: width * .1,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      AppTheme
                                                                          .radiusAvatar)),
                                                          border: Border.all(
                                                              color: AppTheme
                                                                  .black70)),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                                child:
                                                                    IconButton(
                                                              onPressed: () {
                                                                counter[
                                                                    index]--;
                                                                if (counter[
                                                                        index] <
                                                                    0) {
                                                                  counter[
                                                                      index] = 0;
                                                                }
                                                                _sumTicket[
                                                                    index] = counter[
                                                                        index] *
                                                                    widget
                                                                        .listTickets[
                                                                            index]
                                                                        .price;
                                                                checkCount();
                                                                listFetchTicket[
                                                                            index]
                                                                        .totalTicket =
                                                                    counter[
                                                                        index];
                                                                BuyTicketPage.of(
                                                                            context)
                                                                        !.listFetchCounterTicket =
                                                                    listFetchTicket;
                                                                setState(() {});
                                                              },
                                                              icon: const Icon(
                                                                  Icons.remove),
                                                              iconSize: 50,
                                                              color: Colors
                                                                  .black26,
                                                            )),
                                                            flex: 1,
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              width:
                                                                  width * .15,
                                                              height:
                                                                  width * .1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  left: BorderSide(
                                                                      width:
                                                                          1.5,
                                                                      color: Colors
                                                                          .black26),
                                                                  right: BorderSide(
                                                                      width:
                                                                          1.5,
                                                                      color: Colors
                                                                          .black26),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                counter[index]
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            flex: 1,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons.add),
                                                                iconSize: 50,
                                                                color: Colors
                                                                    .black26,
                                                                onPressed: () {
                                                                  counter[index]++;
                                                                  if(counter[index]> widget.listTickets[index].quantities){
                                                                    counter[index] = widget.listTickets[index].quantities;
                                                                  }
                                                                  else if (counter[index] >10) {
                                                                    counter[index] = 10;
                                                                  }
                                                                  _sumTicket[index] = counter[index] * widget.listTickets[index].price;
                                                                  checkCount();
                                                                  listFetchTicket[index]
                                                                          .totalTicket =
                                                                      counter[
                                                                          index];
                                                                  BuyTicketPage.of(
                                                                              context)
                                                                          !.listFetchCounterTicket =
                                                                      listFetchTicket;
                                                                  setState(
                                                                      () {});
                                                                },
                                                              ),
                                                            ),
                                                            flex: 1,
                                                          ),
                                                        ],
                                                      )),
                                                  flex: 8,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                                  },
                                  itemCount: widget.listTickets.length,
                                ),
                                flex: 8,
                              ),
                            Expanded(
                              child: Container(
                                // alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    left: width * .03, right: width * .03),
                                decoration: const BoxDecoration(
                                    border: const Border(
                                        top: const BorderSide(
                                            color: Colors.black26, width: 1))),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "(Bán từ ${FormatDate.getDateMonthDay(widget.hostedAt, widget.endedAt)})",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Text(
                                          "Tổng tiền: ${FormatMoney.coverPrice(sumTickets(_sumTicket))} ",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      flex: 1,
                                    ),
                                  ],
                                ),
                              ),
                              flex: 2,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 50,
                      ));
          }
        },
      ),
    );
  }

  int sumTickets(List<int> i) {
    int k = 0;
    for (int j = 0; j < i.length; j++) {
      k += i[j];
    }
    return k;
  }

  void checkCount() {
    int k = 0;
    for (int i = 0; i < counter.length; i++) {
      k += counter[i];
    }
    if (k > 0) {
      BuyTicketPage.of(context)!.sumMoneyAndCountTicket = TicketTypeModel(
          isCheck: true, sumTicket: sumTickets(_sumTicket), counter: k);
    } else {
      BuyTicketPage.of(context)!.sumMoneyAndCountTicket =
          TicketTypeModel(isCheck: false, sumTicket: 0, counter: 0);
    }
  }
}
