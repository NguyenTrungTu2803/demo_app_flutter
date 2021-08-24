import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListMyTicketBloc extends Bloc<ListMyTicketEvent, ListMyTicketState> {
  ApiServer apiServer;
  ListMyTicketBloc({ListMyTicketState? initialState,required this.apiServer})
      : super(initialState!);

  @override
  Stream<ListMyTicketState> mapEventToState(ListMyTicketEvent event) async* {
    try {
      if (event is ListMyTicketRefreshEvent) {
        var dataRefresh = await apiServer.getListMyTicket(
            'Bearer ${SharedPreferencesUtil.getString(tokenUser)}', event.page);
        yield ListMyTicketSuccessState(
            list: dataRefresh.data, hasReachedEnd: false);
      }
      if (event is ListMyTicketInitEvent) {
        yield ListMyTicketInitState();
      } else if (event is ListMyTicketFetchEvent && !_hasReachedEnd(state)) {
        if (state is ListMyTicketInitState) {
          var dataInitSuccess = await apiServer.getListMyTicket(
              'Bearer ${SharedPreferencesUtil.getString(tokenUser)}',
              event.page);
          yield ListMyTicketSuccessState(
              list: dataInitSuccess.data, hasReachedEnd: false);
        } else if (state is ListMyTicketSuccessState) {
          final currentState = state as ListMyTicketSuccessState;
          var dataSuccess = await apiServer.getListMyTicket(
              'Bearer ${SharedPreferencesUtil.getString(tokenUser)}',
              event.page);
          yield ListMyTicketLoadingState();
          if (dataSuccess.data.isEmpty) {
            yield currentState.cloneWith(hasReachedEnd: true);
          } else {
            yield ListMyTicketSuccessState(
                list: currentState.list + dataSuccess.data,
                hasReachedEnd: false);
          }
        }
      }
    } catch (error) {
      yield ListMyTicketErrorState();
    }
  }

  bool _hasReachedEnd(ListMyTicketState state) =>
      state is ListMyTicketSuccessState && state.hasReachedEnd;
}
