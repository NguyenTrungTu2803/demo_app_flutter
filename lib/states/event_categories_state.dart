import 'package:equatable/equatable.dart';
import 'package:flutter_app_beats/models/tag/event_categories/data_categories.dart';

class EventCategoriesState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class EventCategoriesFetchedState extends EventCategoriesState{}
class EventCategoriesStateInit extends EventCategoriesState{}
class EventCategoriesStateError extends EventCategoriesState{}
class EventCategoriesStateSuccess extends EventCategoriesState{
  final List<DataCategories> listEventCategories;

  EventCategoriesStateSuccess({required this.listEventCategories});
}