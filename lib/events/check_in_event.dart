import 'package:equatable/equatable.dart';

abstract class CheckInEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CheckInInitEvent extends CheckInEvent{}
class CheckInSuccessEvent extends CheckInEvent{}

class CheckInLoadingEvent extends CheckInEvent{
  final String qr;
  CheckInLoadingEvent({required this.qr});
}
class CheckInErrorEvent extends CheckInEvent{}