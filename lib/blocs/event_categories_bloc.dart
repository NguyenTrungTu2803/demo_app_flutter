import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/event_categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCategoriesBloc extends Bloc<EventCategoriesEvent, EventCategoriesState>{
  final ApiServer apiServer;
  EventCategoriesBloc({required this.apiServer,EventCategoriesState? initialState}) : super(initialState!);

  @override
  Stream<EventCategoriesState> mapEventToState(EventCategoriesEvent event) async*{
    if(event is EventCategoriesStartEvent){
      yield EventCategoriesStateInit();
      try{
        var dataTags = await apiServer.fetchEventCategories();
        if(dataTags.status == 200){
          yield EventCategoriesStateSuccess(listEventCategories: dataTags.data);
        }else{
          yield EventCategoriesStateError();
        }
      }catch(error){
        yield EventCategoriesStateError();
      }
    }
  }
  
}