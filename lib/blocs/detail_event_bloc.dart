import 'dart:ffi';

import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_beats/models/model.dart';

class DetailEventBloc extends Bloc<DetailEvent, DetailState >{
  ApiServer apiDetail;
  DetailEventBloc({DetailState? initialState,required this.apiDetail}) : super(initialState!);

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async*{
    BodyDetail bodyDetail = BodyDetail(id: 0);
    if(event is DetailStartEvent){
      yield DetailStateFetched();
      bodyDetail.id = event.id;
      try{
        var detail = await apiDetail.fetchDetailEvent(bodyDetail.id);
        if(detail.status == 200){
          yield DetailStateSuccess(eventModel: detail.dataDetailEvent);
        }else{
          yield DetailStateError();
        }
      }catch(error){
        yield DetailStateError();
      }
    }

    if (event is CreateFollowFetchedEvent) {
      try {
        var data = await apiDetail.pushMyFollow(
            'Bearer ' + SharedPreferencesUtil.getString(tokenUser),
            event.followableId,
            event.followableType);
        if(data.status == 200){
          yield CreateFollowSuccessState();
        }
      } catch (error) {
        yield CreateFollowErrorState();
      }
    }
    if (event is DeleteFollowFetchedEvent) {
      try {
        var data = await apiDetail.deleteMyFollow(
            'Bearer ' + SharedPreferencesUtil.getString(tokenUser),
            event.id,);
        if(data.status == 200){
          yield DeleteFollowSuccessState();
        }
      } catch (error) {
        yield DeleteFollowErrorState();
      }
    }
  }

}