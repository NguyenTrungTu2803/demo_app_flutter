import 'package:equatable/equatable.dart';

abstract class EventCategoriesEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class EventCategoriesStartEvent extends EventCategoriesEvent{}
class EventCategoriesErrorEvent extends EventCategoriesEvent{}