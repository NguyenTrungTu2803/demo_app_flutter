import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayPage extends StatefulWidget {
  @override
  _PagePageState createState() => _PagePageState();
}

class _PagePageState extends State<PayPage> {
  late Timer _timer;
  // double width = window.physicalSize.width;
  // double height = window.physicalSize.height;
  late bool _isHide;
  late int _secondsTime;
  late String _textTime;
  @override
  void initState() {
    _isHide = false;
    _secondsTime = 5;
    _textTime = _secondsTime.toString();
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.red, statusBarIconBrightness: Brightness.light),
          titleSpacing: 2.0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          title: const Text(
            "Payment",
          ),
          backgroundColor: Colors.red,
          leading:
            IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )

        ),
        body: SafeArea(
          child: Container(
            color: _isHide ? Colors.white : Colors.black12,
            width: width,
            height: height,
            child: Stack(
              children: <Widget>[
                !_isHide ? Positioned(
                  top: 0, left: 0, right: 0, bottom: 0,
                    child: Container(
                       child: Center( child: Platform.isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                      ),
                    )):
                Positioned(
                    bottom: width * .02,
                    left: width * .02,
                    right: width * .02,
                    child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        color: Colors.red,
                        onPressed: () {},
                        child: Container(
                            height: 50,
                            child: Center(
                              child: const Text(
                                "Payment",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ))))
              ],
            ),
          ),
        ));
    //));
  }

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsTime > 0) {
          _secondsTime--;
          _textTime = "0" + _secondsTime.toString();
        } else {
          _isHide = true;
          _timer.cancel();
        }
      });
    });
  }
}
