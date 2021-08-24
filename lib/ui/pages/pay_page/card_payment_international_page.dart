import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_beats/bases/route/name_route.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/ui/pages/ticket/model/fetch_ticket.dart';
import 'package:flutter_app_beats/utils/toast_util.dart';

class CardPaymentInternationalPage extends StatefulWidget {
  final String imageBank;
  final String typeBank;
  final List<FetchTicket> list;
  CardPaymentInternationalPage({required this.imageBank, required this.typeBank,required  this.list});

  @override
  _CardPaymentInternationalPageState createState() => _CardPaymentInternationalPageState();
}

class _CardPaymentInternationalPageState extends State<CardPaymentInternationalPage> {
  late PaymentBloc _paymentBloc;
  late TextEditingController _numberTEC;
  late TextEditingController _nameTEC;
  late TextEditingController _codeCVVTEC;
  late TextEditingController _dateTEC;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool onPressed = false;
  @override
  void initState() {
    _paymentBloc = PaymentBloc();
    _numberTEC = MaskedTextController(mask: '0000 0000 0000 0000', text: '', translator: {});
    _nameTEC = TextEditingController();
    _codeCVVTEC = MaskedTextController(mask: '0000', text: '', translator: {});
    _dateTEC = MaskedTextController(mask: '00/0000', text: '', translator: {});
    super.initState();
  }

  @override
  void dispose() {
    _paymentBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppTheme.red,
                statusBarIconBrightness: Brightness.light),
            backgroundColor: AppTheme.red,
            elevation: 2.0,
            centerTitle: true,
            title: Text(
              'Payment',
              style: AppTheme.titleAppBar1,
            ),
          ),
          body: Padding(
            padding: AppTheme.paddingLeftRightScreenApp1,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      '${widget.imageBank }',
                      fit: BoxFit.contain,
                      height: width*.1,
                      width: width*.15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      '${widget.typeBank}',
                      style: AppTheme.captionBlack1,
                    ),
                  ),
                  Container(
                    margin: AppTheme.marginTopScreen,
                    child: NumberCard(
                      width: width,
                      numberTEC: _numberTEC,
                      paymentBloc: _paymentBloc,
                    ),
                  ),
                  Container(
                    margin: AppTheme.marginTopScreen,
                    child: NameCard(
                      width: width,
                      nameTEC: _nameTEC,
                      paymentBloc: _paymentBloc,
                    ),
                  ),
                  Container(
                    margin: AppTheme.marginTopScreen,
                    child: DateCard(
                      width: width,
                      dateTEC: _dateTEC,
                      paymentBloc: _paymentBloc,
                    ),
                  ),
                  Container(
                    margin: AppTheme.marginTopScreen,
                    child: CodeCVVCard(
                      width: width,
                      codeCVVTEC: _codeCVVTEC,
                      paymentBloc: _paymentBloc,
                    ),
                  ),
                  Container(
                      margin: AppTheme.marginTopScreen,
                      child: StreamBuilder<bool>(
                        stream: _paymentBloc.submitValid,
                        builder: (context, snapshot) => RaisedButton(
                          color: AppTheme.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0)),
                          onPressed: snapshot.hasData ? () {
                            ToastUtil.showToastDefault('Payment success');
                            Navigator.of(context).pushNamed(eventPaymentPage);
                          } : null,
                          child: Container(
                              height: width * .15,
                              width: width * .7,
                              child: Center(
                                child: Text(
                                  'Payment',
                                  style: AppTheme.textStyleWhite1,
                                ),
                              )),
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
class NumberCard extends StatelessWidget {
  final TextEditingController numberTEC;
  final PaymentBloc paymentBloc;
  final double width;
  NumberCard({required this.numberTEC,required  this.paymentBloc,required  this.width});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: paymentBloc.numberCardS,
        builder: (context, snapshot) => TextField(
          onChanged: paymentBloc.numberChange,
          controller: numberTEC,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: width*.035),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            errorText: snapshot.error.toString(),
            errorStyle: TextStyle(color: Colors.red, fontSize: width*.035),
            labelText: 'Number Card',
            labelStyle: TextStyle(color: Colors.black87, fontSize: width*.035),
            hintText: 'XXXX-XXXX-XXXX-XXXX',
            hintStyle:  TextStyle(color: Colors.black26, fontSize: width*.035),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            border: const OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(100.0)),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.red,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(100.0)),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.red,
                )),
          ),
        ));
  }
}

class NameCard extends StatelessWidget {
  final TextEditingController nameTEC;
  final PaymentBloc paymentBloc;
  final double width;
  NameCard({required this.nameTEC,required  this.paymentBloc,required  this.width});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: paymentBloc.nameCardS,
        builder: (context, snapshot) =>TextField(
          onChanged: paymentBloc.nameChange,
          textCapitalization: TextCapitalization.characters,
          controller: nameTEC,
          keyboardType: TextInputType.name,
          style: TextStyle(color: Colors.black, fontSize: width*.035),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            errorText: snapshot.error.toString(),
            errorStyle: TextStyle(color: Colors.red, fontSize: width*.035),
            labelText: 'Name Card',
            labelStyle: TextStyle(color: Colors.black87, fontSize: width*.035),
            hintText: 'NGUYEN VAN A',
            hintStyle: TextStyle(color: Colors.black26,fontSize: width*.035),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            border: const OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(100.0)),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.red,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(100.0)),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.red,
                )),
          ),
        ));
  }
}

class DateCard extends StatelessWidget {
  final double width;
  final TextEditingController dateTEC;
  final PaymentBloc paymentBloc;
  DateCard({required this.dateTEC,required  this.paymentBloc,required  this.width});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: paymentBloc.dateCardS,
        builder: (context, snapshot) =>TextField(
          onChanged:
          paymentBloc.dateChange,
          controller: dateTEC,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontSize: width*.035),
          decoration: InputDecoration(
            errorText: snapshot.error.toString(),
            errorStyle: TextStyle(color: Colors.red,fontSize: width*.035),
            labelText: 'Expiration Date',
            labelStyle: TextStyle(color: Colors.black87, fontSize: width*.035),
            hintText: 'XX/XXXX',
            hintStyle: TextStyle(color: Colors.black26, fontSize: width*.035),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            border: const OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(100.0)),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.red,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(100.0)),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.red,
                )),
          ),
        ));
  }
}

class CodeCVVCard extends StatelessWidget {
  final TextEditingController codeCVVTEC;
  final PaymentBloc paymentBloc;
  final double width;
  CodeCVVCard({required this.codeCVVTEC,required  this.paymentBloc,required  this.width});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: paymentBloc.codeCVVS,
        builder: (context, snapshot) =>TextField(
          onChanged: paymentBloc.codeCVVChange,
          controller: codeCVVTEC,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black, fontSize:  width*.035),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            errorText: snapshot.error.toString(),
            labelText: 'CVV/CVC',
            errorStyle: TextStyle(color: Colors.red, fontSize:  width*.035),
            labelStyle: TextStyle(color: Colors.black87,fontSize:  width*.035),
            hintText: 'XXX',
            hintStyle:  TextStyle(color: Colors.black26, fontSize:  width*.035),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
            border: const OutlineInputBorder(
              borderRadius:
              const BorderRadius.all(Radius.circular(100.0)),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.red,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(100.0)),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.red,
                )),
          ),
        ));
  }
}
class MaskedTextController extends TextEditingController {
  Map<String, RegExp> translator;
  MaskedTextController(
      {required String text, required  this.mask,required, required this.translator })
      : super(text: text) {
    this.translator = translator;

    addListener(() {
      final String previous = _lastUpdatedText;
      if (beforeChange(previous, this.text)) {
        updateText(this.text);
        afterChange(previous, this.text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(this.text);
  }

  String mask;


  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text.isNotEmpty) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection = TextSelection.fromPosition(TextPosition(offset: text.length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      try{
        if (maskCharIndex == mask.length) {
          break;
        }
      }catch(error){

      }
      // if (maskCharIndex == mask!.length) {
      //
      // }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        try{
          if (translator[maskChar]!.hasMatch(valueChar)) {
            result += valueChar;
            maskCharIndex += 1;
          }
        }catch(error){

        }


        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
