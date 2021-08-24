import 'package:equatable/equatable.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/fetch_ticket.dart';

abstract class BuyTicketEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class BuyTicketLoadingEvent extends BuyTicketEvent{}
class BuyTicketInitEvent extends BuyTicketEvent{}
class BuyTicketPushEvent extends BuyTicketEvent{
  final List<FetchTicket> body;
  // final int id;
  // final int counterTicket;
  // final int status;

  BuyTicketPushEvent({required this.body});
}
