import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_beats/bases/route/custom_route.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/blocs/create_follow_bloc.dart';
import 'package:flutter_app_beats/blocs/detail_event_bloc.dart';
import 'package:flutter_app_beats/blocs/event_categories_bloc.dart';
import 'package:flutter_app_beats/blocs/list_event_item_bloc.dart';
import 'package:flutter_app_beats/blocs/login_bloc.dart';
import 'package:flutter_app_beats/blocs/register_bloc.dart';
import 'package:flutter_app_beats/blocs/ticket_type_bloc.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/repository/network/api_server_account.dart';
import 'package:flutter_app_beats/states/buy_ticket_state.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/pages/page.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
     //SharedPreferencesUtil.clear();
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CheckInBLoc(apiServer: ApiServer.create(),initialState: CheckInInitState() )),
          BlocProvider(create: (context) => ListMyTicketBloc(apiServer: ApiServer.create(),initialState: ListMyTicketInitState() )),
          BlocProvider(create: (context) => CreateFollowBloc(apiServer: ApiServer.create(), )),
          BlocProvider(create: (context) => BuyTicketBloc(apiServer: ApiServer.create(),initialState: BuyTicketInitState() )),
          BlocProvider(create: (context) => EventCategoriesBloc(initialState: EventCategoriesStateInit(),apiServer: ApiServer.create(), )),
          BlocProvider(create: (context) => TagsBloc(apiServer: ApiServer.create())),
          BlocProvider(create: (context) => ForgotPasswordBloc(initialState: ForgotPasswordInitState())),
          BlocProvider(create: (context) => TicketTypeBLoc(list: [])),
          BlocProvider(create: (context)=> DetailEventBloc(apiDetail: ApiServer.create(),initialState:DetailStateInit() )),
          BlocProvider(
              create: (context) => LoginBloc(
                  initialState: LoginInitState(),
                  loginRepository: ApiServerAccount.create())),
          BlocProvider(
              create: (context) => RegisterBloc(
                  initialState: RegisterInitState(),
                  registerRepository: ApiServerAccount.create())),
          BlocProvider(
              create: (context) => ListEventItemBLoc(
                  initialState: ListEventItemStateInitial(),
                  itemListAPI: ApiServer.create())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          //home: GoogleMapPage(),
          //home: EventPaymentPage(),
          home: SharedPreferencesUtil.getInt(rememberMe) == 0 ||
                  SharedPreferencesUtil.getString(tokenUser) == ""
              ? LoginPage()
              : EventPage(),
          onGenerateRoute: CustomRoute.allRoute,
          //initialRoute: loginPage,
        ));
  }
}
