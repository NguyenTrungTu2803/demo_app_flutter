import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/states/list_my_ticket_state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_app_beats/ui/pages/event_payment/tab_purchased_event.dart';
import 'package:flutter_app_beats/ui/pages/event_payment/tab_resolved_ticket.dart';
import 'package:flutter_app_beats/ui/widgets/widget.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPaymentPage extends StatefulWidget {
  @override
  _EventPaymentPageState createState() => _EventPaymentPageState();
}

class _EventPaymentPageState extends State<EventPaymentPage> {
  late ListMyTicketBloc _listMyTicketBloc;

  @override
  void initState() {
    _listMyTicketBloc = BlocProvider.of<ListMyTicketBloc>(context);
    _listMyTicketBloc.add(ListMyTicketInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: AppTheme.background,
            appBar: AppBar(
              title: Text(
                'Vé của bạn',
              ),
              backgroundColor: AppTheme.red,
              leading: IconButton(
                color: Colors.white,
                //iconSize: AppTheme.sizeIcon1,
                onPressed: () {
                  if(Navigator.of(context).canPop()){
                    Navigator.pop(context, eventPage);
                  }else  Navigator.pushNamedAndRemoveUntil(context, eventPage, (Route<dynamic> route) => false);
                },
                icon: Platform.isAndroid
                    ? const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
              ),
              actions: [
                PopupMenu.popupMenuMyTicket(context, width),
              ],
              centerTitle: true,
              titleTextStyle: AppTheme.titleAppBar1,
              backwardsCompatibility: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: AppTheme.red,
              ),
              bottom: PreferredSize(
                preferredSize: AppBar().preferredSize,
                child: TabBar(
                  indicatorColor: AppTheme.white,
                  tabs: <Widget>[
                    Container(
                      height: AppBar().preferredSize.height,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.sticky_note_2),
                          Text('Vé chưa giải guyết'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.auto_delete),
                        Text('Vé đã giải quyết'),
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: BlocConsumer<ListMyTicketBloc, ListMyTicketState>(
              listener: (context, stateL)
                {
                  if(stateL is ListMyTicketErrorState){
                    IOSDialog.showDialogLogout(context, 'Bạn vui lòng đăng nhập lại?', (){
                      Navigator.of(context).pushNamedAndRemoveUntil(loginPage, (Route<dynamic>route) => false);
                      SharedPreferencesUtil.clear();
                    });
                  }
                },
             builder: (context, state) {
               if(state is ListMyTicketInitState){
                    _listMyTicketBloc.add(ListMyTicketFetchEvent(page: 1));
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
                  }
              if (state is ListMyTicketSuccessState) {
                var data = state.list;
                return TabBarView(
                  children: <Widget>[
                    TabPurchasedEvent(dataListMyTicket: data,hasReachedEnd: state.hasReachedEnd,bloc: _listMyTicketBloc,),
                    TabResolvedTicket(dataListMyTicket: data,hasReachedEnd: state.hasReachedEnd,bloc: _listMyTicketBloc,),
                  ],
                );
              } else
                return Container();
            })));
  }
}
