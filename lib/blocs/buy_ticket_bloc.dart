import 'package:flutter_app_beats/events/buy_ticket_event.dart';
import 'package:flutter_app_beats/models/buy_ticket/body_buy_ticket.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/buy_ticket_state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyTicketBloc extends Bloc<BuyTicketEvent, BuyTicketState> {
  ApiServer apiServer;
  BuyTicketBloc({BuyTicketState? initialState,required this.apiServer})
      : super(initialState!);

  @override
  Stream<BuyTicketState> mapEventToState(BuyTicketEvent event) async* {
    BodyBuyTicket bodyBuyTicket = BodyBuyTicket(ticketId: 0, status: 1, quantities: 0);
    try {
      if (event is BuyTicketLoadingEvent)
        yield BuyTicketInitState();
      else if (event is BuyTicketPushEvent) {
        yield BuyTicketLoadingState();

        for(int i = 0; i< event.body.length; i++){
          if(event.body[i].totalTicket !=0){
            bodyBuyTicket.status = event.body[i].status;
            bodyBuyTicket.quantities = event.body[i].totalTicket;
            bodyBuyTicket.ticketId = event.body[i].id;
            print(bodyBuyTicket.ticketId);
            var data = await apiServer.pushBuyTicket(
                'Bearer ${SharedPreferencesUtil.getString(tokenUser)}',
                bodyBuyTicket);
            if (data.status == 200) {
              yield BuyTicketPushSuccessState();
            } else {
              yield BuyTicketErrorState();
            }

          }

        }
      }
    } catch (error) {
      yield BuyTicketErrorState();
    }
  }
}
