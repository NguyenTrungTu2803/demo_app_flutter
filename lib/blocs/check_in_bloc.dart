
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInBLoc extends Bloc<CheckInEvent, CheckInState>{
  ApiServer apiServer;
  CheckInBLoc({CheckInState? initialState, required this.apiServer}) : super(initialState!);


  @override
  Stream<CheckInState> mapEventToState(CheckInEvent event) async*{
    if(event is CheckInInitEvent){
      yield CheckInInitState();
    }else if(event is CheckInLoadingEvent){
      yield CheckInLoadingState();
      try{
        final data = await apiServer.patchCheckIn(event.qr);
        if(data.status == 200){
          yield CheckInSuccessState();
        }
      }catch(error){
        yield CheckInErrorState();
      }
    }
  }

}