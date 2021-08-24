import 'package:equatable/equatable.dart';

abstract class ListEventItemEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class ListEventItemEndEvent extends ListEventItemEvent{}
class ListEventItemInitEvent extends ListEventItemEvent{}
class ListEventItemFetchedEvent extends ListEventItemEvent{
  final page;
  final int id;

  ListEventItemFetchedEvent({required this.id,required this.page});
}
class ListEventItemRefreshEvent extends ListEventItemEvent{
  final int id;
  final int page;
  ListEventItemRefreshEvent({required this.id,required this.page});
}