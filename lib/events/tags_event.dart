import 'package:equatable/equatable.dart';

abstract class TagsEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class TagsStartEvent extends TagsEvent{}
class TagsErrorEvent extends TagsEvent{}