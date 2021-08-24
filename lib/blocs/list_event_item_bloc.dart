import 'dart:math';
import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/other/constant/app_constant.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/state.dart';
import 'package:flutter_app_beats/utils/shared_preferences_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class ListEventItemBLoc extends Bloc<ListEventItemEvent, ListEventItemState> {

  ApiServer itemListAPI;
  ListEventItemBLoc({ListEventItemState? initialState,required this.itemListAPI})
      : super(initialState!);
  @override
  Stream<Transition<ListEventItemEvent, ListEventItemState>> transformEvents(
    Stream<ListEventItemEvent> events,
    TransitionFunction<ListEventItemEvent, ListEventItemState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListEventItemState> mapEventToState(ListEventItemEvent event) async* {

    if(event is ListEventItemRefreshEvent){
      try{
        final itemListRefresh = await itemListAPI.fetchListItemEvent(event.page, event.id);
        yield ListEventItemStateSuccess(
            list: itemListRefresh.dataListEvent, hasReachedEnd: false);
      }catch(error){

      }
    }
    if (event is ListEventItemInitEvent) {
      yield ListEventItemStateInitial();

    }else if((event is ListEventItemFetchedEvent) && !_hasReachedEnd(state)){
      try {

        if (state is ListEventItemStateInitial) {
          // first time loading page
          // 1. get ListItem from API
          // 2. yield itemList success
          //_page = 1;
          final itemList = await itemListAPI.fetchListItemEvent(event.page, event.id);
          yield ListEventItemStateSuccess(
              list: itemList.dataListEvent, hasReachedEnd: false);

        }
        else if (state is ListEventItemStateSuccess) {
          final currentState = state as ListEventItemStateSuccess;
          final list = await itemListAPI.fetchListItemEvent(event.page, event.id);
          yield ListEventItemStateLoading();
          if (list.dataListEvent.isEmpty) {
            // change current state.
            yield currentState.cloneWith(hasReachedEnd: true);
          } else {
            // not empty, means "not reach end"
            yield ListEventItemStateSuccess(
                list: currentState.list + list.dataListEvent,
                hasReachedEnd: false);
          }
        }
      } catch (error) {
        yield ListEventItemStateFail();
      }
    }
  }

  bool _hasReachedEnd(ListEventItemState state) =>
      state is ListEventItemStateSuccess && state.hasReachedEnd;
}
