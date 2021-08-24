import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/models/detail/data_tickets.dart';
import 'package:flutter_app_beats/other/format_money.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/ui/pages/ticket/buy_ticket_page/ticker_type.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/fetch_ticket.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/payment_model.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/ticket_type_model.dart';
import 'package:flutter_app_beats/ui/widgets/animation_transition/slide_left_transition.dart';
import 'package:flutter_app_beats/ui/widgets/head_title_card.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'payment_bank.dart';

class BuyTicketPage extends StatefulWidget {
  final String dateStart;
  final String address;
  final String dateEnd;
  final String linkImage;
  final int id;
  final List<DataTickets> listTicker;
  BuyTicketPage({
    required this.dateStart,
    required this.linkImage,
    required this.listTicker,
    required this.address,
    required this.dateEnd,
    required this.id
  });

  static _BuyTicketPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_BuyTicketPageState>();
  @override
  _BuyTicketPageState createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {

  List<FetchTicket> _listFetTicket= [];
  int _timerSecond = 1000;
  int _sumMoneyTicket = 0;
  int _counter = 0;
  String _second = "00";
  String _minute = "00";
  String _titlePayment = '';
  String _linkImage = '';
  late Timer _timer;
  bool _checkValida = false;
  bool _checkTickets = false;
  bool _selectedPayment = false;
  bool _indexClickBank = false;

  set listFetchCounterTicket(List<FetchTicket> value)=>setState((){
    _listFetTicket = value;
  });
  set sumMoneyAndCountTicket(TicketTypeModel value) => setState(() {
        _checkTickets = value.isCheck;
        _sumMoneyTicket = value.sumTicket;
        _counter = value.counter;
      });
  set isSelectedPayment(PaymentModel value) => setState(() {
        _selectedPayment = value.selected;
        _linkImage = value.linkImage;
        _titlePayment = value.titlePayment;
        _indexClickBank = value.indexBank;
      });
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Material(
          child: Container(
            height: height - AppBar().preferredSize.height-height*.03,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: ModalScrollController.of(context),
              padding: EdgeInsets.only(bottom: width * .05),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return const Icon(
                            Icons.close,
                            color: Colors.black,
                          );
                        } else {
                          return const Icon(
                            Icons.close,
                            size: 50,
                            color: Colors.black,
                          );
                        }
                      }),
                      onPressed: () {
                        //SharedPreferencesUtil.putInt(sumTicket, 0);
                        Navigator.of(context).pop();
                      },
                    ),
                    width: width,
                    height: width * .5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(widget.linkImage,
                      ),
                    )),
                  ),
                  Padding(
                    padding: AppTheme.paddingLeftRightTopScreen1,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Container(
                            width: width,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: const Icon(
                                        Icons.watch_later_rounded,
                                        color: AppTheme.red,
                                        size: AppTheme.sizeIcon1,
                                      ),
                                    ), flex: 1,),
                                    Expanded(child: Text(
                                      '${FormatDate.getDateUTC(widget.dateStart,widget.dateEnd, )}',
                                      style: AppTheme.textRedBold500_1,
                                    ), flex: 9,),
                                  ],
                                ),
                                Padding(
                                  padding: AppTheme.paddingTopScreen,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: const Align(alignment:Alignment.centerLeft,child: const Icon(Icons.add_location, size: AppTheme.sizeIcon1,color: AppTheme.black,)),
                                        flex: 1,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child:
                                              Text("Công Khai: ${widget.address}", style: AppTheme.captionBlack1,),
                                        ),
                                        flex: 9,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            width: width,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(child: const Icon(
                                      Icons.watch_later_rounded,
                                      color: Colors.red,
                                      size: 50,
                                    ), flex: 1,),
                                    Expanded(child: Text(
                                      '${FormatDate.getDateUTC(widget.dateStart,widget.dateEnd, )}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.red),
                                    ), flex: 10,),
                                  ],
                                ),
                                SizedBox(
                                  height: height * .01,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: const Icon(
                                        Icons.add_location,
                                        size: 50,
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          "Công Khai: ${widget.address}",
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.black),
                                        ),
                                      ),
                                      flex: 10,
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  TicketType(
                      listTickets: widget.listTicker,
                      endedAt: widget.dateEnd,
                      hostedAt: widget.dateStart,
                      id: widget.id,
                      sumCallback: (val) => setState(() {
                            _checkTickets = val.isCheck;
                            _sumMoneyTicket = val.sumTicket;
                            _counter = val.counter;
                          }),
                    listFetchCounterTicket: (val)=> setState((){
                      _listFetTicket = val;
                    }),
                  ),
                  Padding(
                    padding:AppTheme.paddingLeftRightTopScreen1,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 600) {
                          return Card(
                              color: Colors.white,
                              elevation: 2.0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(AppTheme.radiusCard1)),
                                  side: const BorderSide(
                                      color: AppTheme.black38, width: .5)),
                              child: Container(
                                height: width * .3,
                                child: Column(
                                  children: <Widget>[
                                    HeadTitleCard.headTitleCard(['thời gian book vé']),
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * .1,
                                              height: width * .1,
                                              child: Center(
                                                child: const Text(
                                                  "00",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10.0)),
                                                  border: Border.all(
                                                      color: Colors.black38)),
                                            ),
                                            Align(
                                                widthFactor: 5,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  ":",
                                                  style: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * .1,
                                              height: width * .1,
                                              child: Text(
                                                _minute,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10.0)),
                                                  border: Border.all(
                                                      color: Colors.black38)),
                                            ),
                                            Align(
                                              widthFactor: 5,
                                                alignment: Alignment.center,
                                                child: const Text(
                                                  ":",
                                                  style: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * .1,
                                              height: width * .1,
                                              child: Text(
                                                _second,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10.0)),
                                                  border: Border.all(
                                                      color: Colors.black38)),
                                            )
                                          ],
                                        ),
                                      ),
                                      flex: 4,
                                    )
                                  ],
                                ),
                              ));
                        } else {
                          return Card(
                              color: Colors.white,
                              elevation: 2.0,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0)),
                                  side: const BorderSide(
                                      color: Colors.black26, width: .5)),
                              child: Container(
                                height: width * .3,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: width,
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(25.0),
                                                topLeft: Radius.circular(25.0))),
                                        child: const Text(
                                          "VÉ CỦA BẠN ĐƯỢC BOOK",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                      flex: 3,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * .1,
                                              height: width * .1,
                                              child: const Text(
                                                "00",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20.0)),
                                                  border: Border.all(
                                                      color: Colors.black26)),
                                            ),
                                            SizedBox(
                                              width: width * .1,
                                              height: width * .1,
                                              child: Center(
                                                child: const Text(
                                                  ":",
                                                  style: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * .1,
                                              height: width * .1,
                                              child: Text(
                                                _minute,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20.0)),
                                                  border: Border.all(
                                                      color: Colors.black26)),
                                            ),
                                            SizedBox(
                                              width: width * .1,
                                              height: width * .1,
                                              child: Center(
                                                child: const Text(
                                                  ":",
                                                  style: const TextStyle(
                                                      color: Colors.black45,
                                                      fontSize: 50,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: width * .1,
                                              height: width * .1,
                                              child: Text(
                                                _second,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20.0)),
                                                  border: Border.all(
                                                      color: Colors.black26)),
                                            )
                                          ],
                                        ),
                                      ),
                                      flex: 4,
                                    )
                                  ],
                                ),
                              ));
                        }
                      },
                    ),
                  ),
                  PaymentBank(
                      callback: (val) => setState(() {
                            _selectedPayment = val.selected;
                            _titlePayment = val.titlePayment;
                            _linkImage = val.linkImage;
                            _indexClickBank = val.indexBank;
                          })),
                  Padding(
                      padding: AppTheme.paddingLeftRightTopScreen1,
                      child: Container(
                        width: width,
                        height: width * .1,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Checkbox(

                                  activeColor: Colors.white,
                                  checkColor: Colors.black,
                                  value: _checkValida,
                                  onChanged: (check) {
                                    _checkValida = check!;
                                    if (!_checkTickets && _sumMoneyTicket == 0) {
                                      BasePopDialog.showDialogPop(context,
                                          "Chưa chọn vé", "Bạn chưa chọn vé");
                                      _checkValida = false;
                                    } else if (!_selectedPayment) {
                                      BasePopDialog.showDialogPop(
                                          context,
                                          "Phương thức thanh toán",
                                          "Bạn chưa chọn phương thức để thanh toán");
                                      _checkValida = false;
                                    }
                                    setState(() {});
                                  },
                                )),
                            Expanded(
                                flex: 10,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (constraints.maxWidth < 600) {
                                      return RichText(
                                        text: const TextSpan(
                                            //style: DefaultTextStyle.of(context).style,
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text: 'Tôi đồng ý với ',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              const TextSpan(
                                                  text: 'Điều Khoản Sử Dụng',
                                                  style: const TextStyle(
                                                    decoration:
                                                        TextDecoration.underline,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                  )),
                                              const TextSpan(
                                                  text:
                                                      ' Và đang mua vé cho người độ tổi thích hợp.',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ]),
                                      );
                                    } else {
                                      return RichText(
                                        text: const TextSpan(
                                            //style: DefaultTextStyle.of(context).style,
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text: 'Tôi đồng ý với ',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20)),
                                              const TextSpan(
                                                  text: 'Điều Khoản Sử Dụng',
                                                  style: const TextStyle(
                                                    decoration:
                                                        TextDecoration.underline,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Colors.red,
                                                  )),
                                              const TextSpan(
                                                  text:
                                                      ' Và đang mua vé cho người độ tổi thích hợp.',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 20)),
                                            ]),
                                      );
                                    }
                                  },
                                ))
                          ],
                        ),
                      )),
                  Padding(
                      padding: AppTheme.paddingLeftRightTopScreen1,
                      child: Container(
                        height: AppTheme.heightButton1,
                        width: width,
                        child: RaisedButton(
                          elevation: 2.0,
                          color: AppTheme.red,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0))),
                          onPressed: _checkValida && _counter != 0
                              ? () {
                                  if (_indexClickBank) {
                                    Navigator.of(context)
                                        .push(SlideLeftTransition(
                                        page: CardPaymentInternationalPage(
                                          list: _listFetTicket,
                                          imageBank: _linkImage,
                                          typeBank: _titlePayment,
                                        )));
                                  } else {

                                    Navigator.of(context).push(SlideLeftTransition(
                                        page: CardPaymentLocalPage(
                                          list: _listFetTicket,
                                          money: _sumMoneyTicket,
                                          /*imageBank: _linkImage, typeBank: _titlePayment,*/)));
                                  }
                                }
                              : null,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (constraints.maxWidth < 600) {
                                return Text(
                                  !_checkValida
                                      ? "Tôi đồng ý và Tiếp tục"
                                      : "Thanh toán: ${FormatMoney.coverPrice(_sumMoneyTicket)}",
                                  style: AppTheme.textStyleWhite1,
                                );
                              } else {
                                return Text(
                                  !_checkValida
                                      ? "Tôi đồng ý và Tiếp tục"
                                      : "Thanh toán: ${FormatMoney.coverPrice(_sumMoneyTicket)}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                );
                              }
                            },
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
  }

  startTimer() {
    //int min = int.parse((_timerSecond/60).toString());
    int min = _timerSecond ~/ 60;
    _minute = min.toString();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSecond > 0) {
          _timerSecond--;
          _second = int.parse((_timerSecond % 60).toString()).toString();
          if (_second == "0") {
            if (min == 0) {
              min = 0;
            } else {
              min--;
            }
            _minute = min.toString();
          }
        } else {
          _minute = "00";
          _timer.cancel();
          BookTicketDialog.showDialogTimeBookTicket(context);
        }
      });
    });
  }
}
