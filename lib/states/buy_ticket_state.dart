import 'package:equatable/equatable.dart';

class BuyTicketState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class BuyTicketInitState extends BuyTicketState{}
class BuyTicketLoadingState extends BuyTicketState{}
class BuyTicketPushSuccessState extends BuyTicketState{}
class BuyTicketErrorState extends BuyTicketState{}