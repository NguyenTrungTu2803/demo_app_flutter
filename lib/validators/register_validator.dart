import 'dart:async';


class RegisterValidator {
  final validaEmail =
  StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    RegExp regExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Email is not available");
    }
  });
  final validaPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length >= 8)
          sink.add(password);
        else
          sink.addError("Password must be ad least 8 characters");
      });
  final validaConfirmPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
        if (password.length >= 8)
          sink.add(password);
        else
          sink.addError("Password must be ad least 8 characters");
      });
  final validaUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
        if (username.length >= 10) {
          sink.add(username);
        } else {
          sink.addError("UserName must be ad least 10 characters");
        }
      });


}
