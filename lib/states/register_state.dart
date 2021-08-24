import 'package:equatable/equatable.dart';

class RegisterState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class RegisterInitState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterExistState extends RegisterState{}
class UserRegisterSuccessState extends RegisterState {}

class AdminRegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState({required this.message});
}