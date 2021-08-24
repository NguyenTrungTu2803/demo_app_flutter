import 'dart:async';

class PaymentValidator {
  final numberValid = StreamTransformer<String, String>.fromHandlers(handleData: (numberCard, sink){
    try{
      if (numberCard.length < 19) {
        sink.addError('Invalid bank card number');
      }
      sink.add(numberCard);
    }catch(error){
      sink.addError('Invalid bank card number');
    }
  });
  final nameCardValid = StreamTransformer<String, String>.fromHandlers(handleData: (nameCard, sink){
    if(nameCard.length>  10){
      sink.add(nameCard);
    }else{
      sink.addError('Invalid name');
    }
  });
  final dateValid = StreamTransformer<String, String>.fromHandlers(handleData: (dateTime, sink){
    // if(dateTime!.isEmpty){
    //   return sink.addError('Invalid date');
    // }
    try{
      final DateTime now = DateTime.now();
      final List<String> date = dateTime.split(RegExp(r'/'));
      final int month = int.parse(date.first);
      final int year = int.parse('${date.last}');
      final DateTime cardDate = DateTime(year, month);

      if (cardDate.isBefore(now) ||
          month > 12 ||
          month == 0) {
        return sink.addError('Invalid date');
      }
      return sink.add(dateTime);
    }catch(error){
      return sink.addError('Invalid date');
    }

  });
  final codeCVVValid = StreamTransformer<String, String>.fromHandlers(handleData: (codeCVV, sink){
    try{
      if (codeCVV.length < 3) {
        sink.addError('Invalid code CVV/CVC');
      }
      sink.add(codeCVV);
    }catch(error){
      sink.addError('Invalid code CVV/CVC');
    }
  });
}