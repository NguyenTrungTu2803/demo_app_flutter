import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_app_beats/other/connectivity_status.dart';

class ConnectivityService{
  StreamController<ConnectivityStatus> connectivityStatusController = StreamController<ConnectivityStatus>();
  ConnectivityService(){
    Connectivity().onConnectivityChanged.listen((event) {connectivityStatusController.add(_getStatusFromResult(event)); });
  }
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result){
    switch(result){
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Online;
        break;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Online;
        break;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
        break;
      default:
        return ConnectivityStatus.Offline;
        break;
    }
  }
}