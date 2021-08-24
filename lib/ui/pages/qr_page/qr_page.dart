import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_beats/blocs/bloc.dart';
import 'package:flutter_app_beats/config/app_theme.dart';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/ui/dialogs/dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.red,
          title: const Text(
            "Check ticket",
            style: AppTheme.titleAppBar1,
          ),
          centerTitle: true,
        ),
        body: QrPageBuild());
  }
}

class QrPageBuild extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPageBuild> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? _controller;
  var result;
  String stringQR = '';
  late CheckInBLoc _checkInBLoc;

  @override
  void initState() {
    _checkInBLoc = BlocProvider.of<CheckInBLoc>(context);
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await _controller!.pauseCamera();
    } else if (Platform.isIOS) {
      await _controller!.resumeCamera();
    }
  }
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) async {
    setState(() => this._controller = controller);
    controller.scannedDataStream.listen((barCode) async {
      setState(() => this.result = barCode.code);
      if (result != null) {
        await _controller!.pauseCamera();
        _checkInBLoc.add(CheckInLoadingEvent(qr: result));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<CheckInBLoc, CheckInState>(
      listener: (context, stateL){
       if(stateL is CheckInLoadingState){
         LoadingDialog.showLoadingDialog(context);
       }else if(stateL is CheckInSuccessState){
         LoadingDialog.hideLoadingDialog(context);
         IOSDialog.showDialogCheckIn(context, true);
       }else{
         LoadingDialog.hideLoadingDialog(context);
         IOSDialog.showDialogCheckIn(context, false);
       }
      },
      child: Column(
        children: [
          Container(
            width: width,
            height: height / 2,
            child: QRView(
                key: qrKey,
                overlay: QrScannerOverlayShape(
                  borderColor: Theme.of(context).cardColor,
                  borderRadius: 10,
                  borderWidth: 10,
                ),
                onQRViewCreated: onQRViewCreated),
          ),
          Padding(padding: AppTheme.paddingAllScreen1, child: Row(
            children: [
              Expanded(
                  child: MaterialButton(
                    onPressed: () async{
                      await _controller!.resumeCamera();
                    },
                    color: AppTheme.red,
                    height: AppTheme.heightButton1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppTheme.radiusButton))),
                    child: Text('Quét mã', style: AppTheme.textStyleWhite1,),
                  ),
                  flex: 4),
              Expanded(child: SizedBox(), flex: 1,),
              Expanded(
                  child: MaterialButton(
                    onPressed: () async{
                      await _controller!.pauseCamera();
                    },
                    color: AppTheme.red,
                    height: AppTheme.heightButton1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppTheme.radiusButton))),
                    child: Text('Dừng camera', style: AppTheme.textStyleWhite1,),
                  ),
                  flex: 4),
            ],
          ),)
        ],
      ),
    );
  }
}
