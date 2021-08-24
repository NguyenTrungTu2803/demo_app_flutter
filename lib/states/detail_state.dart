import 'package:equatable/equatable.dart';
import 'package:flutter_app_beats/models/detail/data_detail_event.dart';

class DetailState extends Equatable{
  @override
  List<Object> get props => [];
}
class DetailStateInit extends DetailState{}
class DetailStateFetched extends DetailState{}
class DetailStateSuccess extends DetailState{
  late final DataDetailEvent eventModel;
  DetailStateSuccess({required this.eventModel});
}
class DetailStateError extends DetailState{}

class CreateFollowSuccessState extends DetailState{}
class CreateFollowErrorState extends DetailState{}
class DeleteFollowSuccessState extends DetailState{}
class DeleteFollowErrorState extends DetailState{}