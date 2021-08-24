import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_beats/config/app_config.dart';
import 'package:flutter_app_beats/models/buy_ticket/body_buy_ticket.dart';
import 'package:flutter_app_beats/models/model.dart';
import 'package:flutter_app_beats/models/tag/tag_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
part 'api_server.g.dart';

@RestApi(baseUrl: AppConfig.urlEvent)
abstract class ApiServer {
  factory ApiServer(Dio dio, {String baseUrl}) = _ApiServer;
  static ApiServer create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiServer(dio);
  }

  @GET('${AppConfig.prefix}/events/?category_id={ca}&page={page}')
  Future<ListEventItemModel> fetchListItemEvent(
    @Path() int page,
    @Path() int ca,
  );
  @GET('${AppConfig.prefix}/events/{id}')
  Future<DetailEventModel> fetchDetailEvent(@Path('id') int id);
  @GET('${AppConfig.prefix}/tags')
  Future<TagModel> fetchTags();
  @GET('${AppConfig.prefix}/event-categories')
  Future<EventCategoriesModel> fetchEventCategories();

  @POST('${AppConfig.prefix}/tickets/buy-ticket')
  Future<BuyTicketModel> pushBuyTicket(@Header('Authorization') String token,
      @Body() BodyBuyTicket bodyBuyTicket);
  @GET('${AppConfig.prefix}/my-tickets?with[]=1&with[]=2&page={page}')
  Future<ListMyTicket> getListMyTicket(
      @Header('Authorization') String token, @Path('page') int page);

  @POST(
      '${AppConfig.prefix}/my-follows?followable_id={followableId}&followable_type={followableType}')
  Future<CreateFollowModel> pushMyFollow(
      @Header('Authorization') String token,
      @Path('followableId') int followableId,
      @Path('followableType') int followableType);

  @DELETE('${AppConfig.prefix}/my-follows/{id}')
  Future<DeleteFollowModel> deleteMyFollow(
      @Header('Authorization') String token, @Path() int id);

  @PATCH('${AppConfig.prefix}/tickets/checkin/?qr={prString}')
  Future<CheckInModel> patchCheckIn(@Path('prString') String prString);
}
