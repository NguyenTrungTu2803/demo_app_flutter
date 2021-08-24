import 'package:equatable/equatable.dart';
import 'package:flutter_app_beats/models/my_ticket/data_list_my_ticket.dart';

class ListMyTicketState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class ListMyTicketInitState extends ListMyTicketState{}
class ListMyTicketLoadingState extends ListMyTicketState{}
class ListMyTicketSuccessState extends ListMyTicketState{
  final List<DataListMyTicket> list;
  final bool hasReachedEnd;

  ListMyTicketSuccessState({required this.list, required this.hasReachedEnd});

  @override
  // TODO: implement props
  List<Object> get props => [list,hasReachedEnd];
  ListMyTicketSuccessState cloneWith({List<DataListMyTicket>? list, bool? hasReachedEnd})=> ListMyTicketSuccessState(
    list: list?? this.list, hasReachedEnd: hasReachedEnd?? this.hasReachedEnd
  );

}
class ListMyTicketErrorState extends ListMyTicketState{}