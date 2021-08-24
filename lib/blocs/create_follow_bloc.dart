import 'package:flutter_app_beats/events/create_follow_event.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/create_follow_state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFollowBloc extends Bloc<CreateFollowEvent, CreateFollowState> {
  ApiServer apiServer;
  CreateFollowBloc({CreateFollowState? initialState,required this.apiServer})
      : super(initialState!);

  @override
  Stream<CreateFollowState> mapEventToState(CreateFollowEvent event) async* {
    if (event is CreateFollowIniEvent) {
      yield CreateFollowInitState();
    }
    if (event is CreateFollowFetchedEvent) {
      try {
        var data = await apiServer.pushMyFollow(
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
  }
}
