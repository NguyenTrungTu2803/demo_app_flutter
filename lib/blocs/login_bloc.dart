import 'dart:async';

import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/model.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server_account.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_app_beats/validators/login_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginRegisterValidator  {
  ApiServerAccount loginRepository;
   final _email = StreamController<String>.broadcast();
  // final _password = StreamController<String>.broadcast();
  // final _username = StreamController<String>.broadcast();
  //final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  //final _username = BehaviorSubject<String>();
  LoginBloc({LoginState? initialState,required this.loginRepository}) : super(initialState!);

  Stream<String> get emailS => _email.stream.transform(validaEmail);
  Stream<String> get passwordS => _password.stream.transform(validaPassword);
  //Stream<String> get usernameS => _username.stream.transform(validaUserName);
  Stream<bool> get submitValid =>
      Rx.combineLatest2( emailS, passwordS, ( e, p) => true);
  Function(String) get emailChange => _email.sink.add;
  //Function(String) get usernameChange => _username.sink.add;
  Function(String) get passwordChange => _password.sink.add;
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    BodyLogin bodyLogin = BodyLogin(email: '', password: '');
    if(event is LoginStartEvent){
      yield LoginInitState();
    }
    else if(event is LoginButtonPress) {
      yield LoginLoadingState();
      bodyLogin.password = event.password;
      bodyLogin.email = event.email;
      try{
        var data = await loginRepository.getLogin(bodyLogin);
        if(data.status == 200) {
          SharedPreferencesUtil.putString(tokenUser, data.data.token);
          SharedPreferencesUtil.putString(email, event.email);
          print(SharedPreferencesUtil.getString(email));
          yield LoginSuccessState();
        }else{
          yield LoginExistState();
        }
      }catch(error){
        yield LoginExistState();
      }
    }else{
      yield LoginErrorState(message: '');
    }
  }
  dispose() {
    _email.close();
    _password.close();
    //_username.close();
  }
}
