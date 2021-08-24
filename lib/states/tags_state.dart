import 'package:equatable/equatable.dart';
import 'package:flutter_app_beats/models/model.dart';

class TagsState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class TagsFetchedState extends TagsState{}
class TagsStateInit extends TagsState{}
class TagsStateError extends TagsState{}
class TagsStateSuccess extends TagsState{
  final List<DataTag> listTags;

  TagsStateSuccess({required this.listTags});
}