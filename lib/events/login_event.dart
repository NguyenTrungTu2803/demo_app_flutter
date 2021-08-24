import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class LoginStartEvent extends LoginEvent{}
class LoginButtonPress extends LoginEvent{
final String email; final String password;

  LoginButtonPress({required this.email,required this.password});
}