import 'package:equatable/equatable.dart';

class CheckInState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CheckInInitState extends CheckInState{}
class CheckInSuccessState extends CheckInState{}
class CheckInLoadingState extends CheckInState{}
class CheckInErrorState extends CheckInState{}