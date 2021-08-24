import 'package:equatable/equatable.dart';

class TicketTypeEvent extends Equatable{
  const TicketTypeEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class TicketTypeDecrementEvent extends TicketTypeEvent{}
class TicketTypeIncrementEvent extends TicketTypeEvent{}