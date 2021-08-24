import 'package:equatable/equatable.dart';

class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterStartEvent extends RegisterEvent {}

class RegisterButtonPress extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterButtonPress(
      {required this.username,required  this.email,required this.password,required this.confirmPassword});
}
