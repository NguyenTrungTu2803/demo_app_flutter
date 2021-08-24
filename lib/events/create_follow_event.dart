import 'package:equatable/equatable.dart';

abstract class CreateFollowEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class CreateFollowIniEvent extends CreateFollowEvent{}
class CreateFollowSuccessEvent extends CreateFollowEvent{}
class CreateFollowFetchedEvent extends CreateFollowEvent{
  final int followableId;
  final int followableType;

  CreateFollowFetchedEvent({required this.followableId,required this.followableType});
}