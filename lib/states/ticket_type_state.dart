import 'package:equatable/equatable.dart';

class TicketTypeState extends Equatable{
  final List<int> counter;
  const TicketTypeState({required this.counter});
  @override
  // TODO: implement props
  List<Object> get props => [counter];
}