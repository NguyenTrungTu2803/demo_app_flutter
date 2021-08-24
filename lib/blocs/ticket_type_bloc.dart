import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketTypeBLoc extends Bloc<TicketTypeEvent, TicketTypeState>{
  final List list;
  TicketTypeBLoc({required this.list}) : super(TicketTypeState(counter:  List.filled(list.length, 0)));

  @override
  Stream<TicketTypeState> mapEventToState(TicketTypeEvent event) async*{
   if(event is TicketTypeIncrementEvent){
     yield TicketTypeState(counter: List.generate(list.length, (index) => state.counter[index]+ 1));
   }else if(event is TicketTypeDecrementEvent){
     yield TicketTypeState(counter: List.generate(list.length, (index) => state.counter[index]- 1));
   }
  }

}