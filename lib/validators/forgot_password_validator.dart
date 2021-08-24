import 'dart:async';

class ForgotPasswordValidator {
  final validEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email is not available');
    }
  });
}
