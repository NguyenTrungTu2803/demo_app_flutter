import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class DetailEventFetchEvent extends DetailEvent{}
class DetailStartEvent extends DetailEvent{
  final int id;
  DetailStartEvent({required this.id});
}
class CreateFollowIniEvent extends DetailEvent{}
class CreateFollowSuccessEvent extends DetailEvent{}
class CreateFollowFetchedEvent extends DetailEvent{
  final int followableId;
  final int followableType;

  CreateFollowFetchedEvent({required this.followableId,required this.followableType});
}
class DeleteFollowIniEvent extends DetailEvent{}
class DeleteFollowSuccessEvent extends DetailEvent{}
class DeleteFollowFetchedEvent extends DetailEvent{
  final int id;

  DeleteFollowFetchedEvent({required this.id});
}