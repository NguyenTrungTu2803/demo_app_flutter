import 'package:flutter_app_beats/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc with PaymentValidator {
  final _numberCard = BehaviorSubject<String>();
  final _nameCard = BehaviorSubject<String>();
  final _codeCVV = BehaviorSubject<String>();
  final _dateCard = BehaviorSubject<String>();
  Stream<String> get numberCardS => _numberCard.stream.transform(nameCardValid);
  Stream<String> get nameCardS => _nameCard.stream.transform(nameCardValid);
  Stream<String> get codeCVVS => _codeCVV.stream.transform(codeCVVValid);
  Stream<String> get dateCardS => _dateCard.stream.transform(dateValid);

  Stream<bool> get submitValid => Rx.combineLatest4(
      numberCardS, nameCardS, codeCVVS, dateCardS, (a, b, c, d) => (true));
  Function(String) get numberChange => _numberCard.sink.add;
  Function(String) get nameChange => _nameCard.sink.add;
  Function(String) get codeCVVChange => _codeCVV.sink.add;
  Function(String) get dateChange => _dateCard.sink.add;

  dispose() {
    _numberCard.close();
    _nameCard.close();
    _codeCVV.close();
    _dateCard.close();
  }
}
