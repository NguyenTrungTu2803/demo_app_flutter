import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/buy_ticket_event.dart';
import 'package:flutter_app_beats/other/other.dart';
import 'package:flutter_app_beats/states/buy_ticket_state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/pages/pay_page/add_image_storage.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/fetch_ticket.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_app_beats/utils/toast_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPaymentLocalPage extends StatefulWidget {
  final int money;
  final List<FetchTicket> list;
  const CardPaymentLocalPage({required this.money, Key? key,required  this.list}) : super(key: key);
  static _CardPaymentLocalPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CardPaymentLocalPageState>();
  @override
  _CardPaymentLocalPageState createState() => _CardPaymentLocalPageState();
}

class _CardPaymentLocalPageState extends State<CardPaymentLocalPage> {
  late BuyTicketBloc _buyTicketBloc;
  late int _listCountImage;
  set listImage(int value) => setState(() {
        _listCountImage = value;
      });
  @override
  void initState() {
    _buyTicketBloc = BlocProvider.of<BuyTicketBloc>(context);
    _listCountImage = 0;
    widget.list.map((e) => print(e.totalTicket)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Payment',
          style: AppTheme.titleAppBar1,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppTheme.red,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppTheme.red,
      ),
      body: BlocListener<BuyTicketBloc, BuyTicketState>(
        listener: (context, state){
          if(state is BuyTicketLoadingState){
            LoadingDialog.showLoadingDialog(context);
          }else if(state is BuyTicketPushSuccessState){
            LoadingDialog.hideLoadingDialog(context);
            ToastUtil.showToastDefault('Payment success');
            Navigator.of(context).pushNamedAndRemoveUntil(eventPaymentPage, (Route<dynamic> route) => false);
          }else if(state is BuyTicketErrorState){
            if(Navigator.canPop(context)){
              LoadingDialog.hideLoadingDialog(context);
              IOSDialog.showDialogLogout(context, 'Vui lòng đăng nhập lại', (){
                Navigator.of(context).pushNamedAndRemoveUntil(loginPage, (Route<dynamic>route) => false);
                SharedPreferencesUtil.clear();
              });
            }

            ToastUtil.showToastDefault('Payment error');

          }else{
            print('error');
          }
        },
        child: SingleChildScrollView(
          reverse: false,
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          child: Padding(
            padding: AppTheme.paddingLeftRightScreenApp1,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: AppTheme.paddingTopScreen,
                  child: Center(
                    child: Text(
                      'Số tiền bạn cần chuyển',
                      overflow: TextOverflow.visible,
                      style: AppTheme.title1,
                    ),
                  ),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  height: 50,
                  width: width*.5,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(AppTheme.radiusAvatar),
                  ),
                  child: Center(
                      child: Text(
                    '${FormatMoney.coverPrice(widget.money)}',
                    style: AppTheme.textStyleWhite1,
                  )),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Chuyển khoản và chụp hóa đơn chuyển khoản ',
                      overflow: TextOverflow.visible,
                      style: AppTheme.captionBlack1,
                    ),
                  ),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Số tài khoản ',
                      overflow: TextOverflow.visible,
                      style: AppTheme.subtitle1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: width * .02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '045100000303069',
                      overflow: TextOverflow.visible,
                      style: AppTheme.captionBlack1
                    ),
                  ),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tên chủ khoản ',
                      overflow: TextOverflow.visible,
                      style: AppTheme.subtitle1,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: width * .02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tên chủ khoản',
                      overflow: TextOverflow.visible,
                      style: AppTheme.captionBlack1
                    ),
                  ),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tên ngân hàng ',
                      overflow: TextOverflow.visible,
                      style: AppTheme.subtitle1
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: width * .02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ngân hàng TechComBank',
                      overflow: TextOverflow.visible,
                      style: AppTheme.captionBlack1
                    ),
                  ),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Chi nhánh',
                      overflow: TextOverflow.visible,
                      style: AppTheme.subtitle1
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: width * .02),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Chi nhánh Paster, Quận 1',
                      overflow: TextOverflow.visible,
                      style: AppTheme.captionBlack1
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: width * .1),
                  child: AddImageStorage(
                    listCountImage: (val) =>
                        setState(() => _listCountImage = val),
                  ),
                ),
                Container(
                  margin: AppTheme.marginTopScreen,
                  padding: AppTheme.paddingBottomCardListViewScreenApp1,
                  child: Container(
                      width: width*.7,
                      height: AppTheme.heightButton1,
                      child: MaterialButton(
                        color: AppTheme.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusAvatar),
                        ),
                        onPressed: _listCountImage >0? () {

                          _buyTicketBloc.add(BuyTicketPushEvent(body: widget.list));
                        setState(() {
                        });
                        }: null,
                        child: Text(
                          'Confirm',
                          style: AppTheme.textStyleWhite1
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
