import 'package:flutter/cupertino.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> with ForgotPasswordValidator {
  final _email = BehaviorSubject<String>();

  ForgotPasswordBloc({ForgotPasswordState? initialState}) : super(initialState!);


  Stream<dynamic> get emailS => _email.stream.transform(validEmail);
  Stream<bool> get submitValid => Rx.combineLatest([emailS], (values) => true);
  Function(String) get emailChange => _email.sink.add;

  dispose() {
    _email.close();
  }

  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async*{
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
