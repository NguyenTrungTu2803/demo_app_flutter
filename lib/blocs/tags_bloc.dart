import 'package:flutter_app_beats/events/event.dart';
import 'package:flutter_app_beats/repository/network/api_server.dart';
import 'package:flutter_app_beats/states/tags_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState>{
  ApiServer apiServer;
  TagsBloc({TagsState? initialState,required this.apiServer}) : super(initialState!);

  @override
  Stream<TagsState> mapEventToState(TagsEvent event) async*{
    if(event is TagsStartEvent){
      try{
        var dataTags = await apiServer.fetchTags();
        if(dataTags.status == 200){
          yield TagsStateSuccess(listTags: dataTags.dataTag);
        }else{
          yield TagsStateError();
        }
      }catch(error){
        yield TagsStateError();
      }
    }

  }

}