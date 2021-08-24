import 'dart:async';

import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/models/model.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server_account.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_app_beats/validators/register_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>
    with RegisterValidator {
  ApiServerAccount registerRepository;
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();
  // final _email = StreamController<String>.broadcast();
  // final _password = StreamController<String>.broadcast();
  // final _username = StreamController<String>.broadcast();
  // final _confirmPassword = StreamController<String>();

  RegisterBloc({RegisterState? initialState,required this.registerRepository})
      : super(initialState!);

  Stream<String> get emailS => _email.stream.transform(validaEmail);
  Stream<String> get passwordS => _password.stream.transform(validaPassword);
  Stream<String> get usernameS => _username.stream.transform(validaUserName);
  Stream<String> get confirmPasswordS => _confirmPassword.stream
          .transform(validaConfirmPassword
              ) // error theo validaPassword truoc roi toi error confirm
          .doOnData((String confirmPassword) {
        if (0 != _password.value.compareTo(confirmPassword)) {
          _confirmPassword.sink.addError("Doesn't match the password");
        }
      });
  Function(String) get emailChange => _email.sink.add;
  Function(String) get usernameChange => _username.sink.add;
  Function(String) get passwordChange => _password.sink.add;
  Function(String) get confirmPasswordChange => _confirmPassword.sink.add;
  Stream<bool> get submitValid => Rx.combineLatest4(
      usernameS, emailS, passwordS, confirmPasswordS, (u, e, o, cp) => true);

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    BodyRegister _body = BodyRegister(email: '', password_confirmation: '', password: '', name: '');
    BodyLogin _bodyLogin =BodyLogin(email: '', password: '');
    if (event is RegisterStartEvent) {
      yield RegisterInitState();
    } else if (event is RegisterButtonPress) {
      yield RegisterLoadingState();
      _body.password = event.password;
      _body.email = event.email;
      _body.password_confirmation = event.confirmPassword;
      _body.name = event.username;
      _bodyLogin.email = event.email;
      _bodyLogin.password = event.password;
      try {
        var data = await registerRepository.fetchRegister(_body);
        if (data.status == 200) {
          final dataLogin = await registerRepository.getLogin(_bodyLogin);
          SharedPreferencesUtil.putString(tokenUser, dataLogin.data.token);
          yield RegisterSuccessState();
        } else {
          yield RegisterExistState();
        }
      } catch (error) {
        yield RegisterExistState();
      }
    } else {
      yield RegisterErrorState(message: '');
    }
  }

  dispose() {
    _email.close();
    _password.close();
    _username.close();
    _confirmPassword.close();
  }
}
