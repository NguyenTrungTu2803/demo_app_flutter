import 'package:equatable/equatable.dart';
import 'package:flutter_app_beats/models/model.dart';

abstract class ListEventItemState extends Equatable {
  //ListEventItemState([List props = const []]); //: super(props);
  @override
  List<Object> get props => [/*props*/];
}

class ListEventItemStateInitial extends ListEventItemState {
  @override
  String toString() => 'ListEventItemStateInitial';
}

class ListEventItemStateFail extends ListEventItemState {
  @override
  String toString() => 'ListEventItemStateFail';
}

class ListEventItemStateLoading extends ListEventItemState {}
class ListEventItemStateRefreshing extends ListEventItemState{}

class ListEventItemStateEnd extends ListEventItemState {}

class ListEventItemStateSuccess extends ListEventItemState {
  final List<DataListEvent> list;
  final bool hasReachedEnd;

  ListEventItemStateSuccess({required this.list,required  this.hasReachedEnd});
      //: super([list, hasReachedEnd]);

  @override
  String toString() {
    return "ListItem : ${list.length}, hasReachedEnd: $hasReachedEnd";
  }

  @override
  // TODO: implement props
  List<Object> get props => [list, hasReachedEnd];

  ListEventItemStateSuccess cloneWith(
      {List<DataListEvent>? comments, bool? hasReachedEnd}) {
    return ListEventItemStateSuccess(
        list: comments ?? this.list,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}
