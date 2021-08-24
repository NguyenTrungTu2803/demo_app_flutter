import 'package:equatable/equatable.dart';

abstract class ListMyTicketEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class ListMyTicketLoadingEvent extends ListMyTicketEvent{}
class ListMyTicketInitEvent extends ListMyTicketEvent{}
class ListMyTicketFetchEvent extends ListMyTicketEvent{
  final int page;

  ListMyTicketFetchEvent({required this.page});
}
class ListMyTicketRefreshEvent extends ListMyTicketEvent{
  final int page;

  ListMyTicketRefreshEvent({required this.page});
}