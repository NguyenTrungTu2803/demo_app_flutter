// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_server.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiServer implements ApiServer {
  _ApiServer(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://event.bcard.mobifocuz.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ListEventItemModel> fetchListItemEvent(page, ca) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListEventItemModel>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(
                    _dio.options, 'api/v1/events/?category_id=$ca&page=$page',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListEventItemModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DetailEventModel> fetchDetailEvent(id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DetailEventModel>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'api/v1/events/$id',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DetailEventModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TagModel> fetchTags() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TagModel>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'api/v1/tags',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TagModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventCategoriesModel> fetchEventCategories() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventCategoriesModel>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, 'api/v1/event-categories',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventCategoriesModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BuyTicketModel> pushBuyTicket(token, bodyBuyTicket) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(bodyBuyTicket.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BuyTicketModel>(Options(
                method: 'POST',
                headers: <String, dynamic>{r'Authorization': token},
                extra: _extra)
            .compose(_dio.options, 'api/v1/tickets/buy-ticket',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BuyTicketModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ListMyTicket> getListMyTicket(token, page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ListMyTicket>(Options(
                method: 'GET',
                headers: <String, dynamic>{r'Authorization': token},
                extra: _extra)
            .compose(
                _dio.options, 'api/v1/my-tickets?with[]=1&with[]=2&page=$page',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ListMyTicket.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CreateFollowModel> pushMyFollow(
      token, followableId, followableType) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        CreateFollowModel>(Options(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra)
        .compose(_dio.options,
            'api/v1/my-follows?followable_id=$followableId&followable_type=$followableType',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateFollowModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteFollowModel> deleteMyFollow(token, id) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteFollowModel>(Options(
                method: 'DELETE',
                headers: <String, dynamic>{r'Authorization': token},
                extra: _extra)
            .compose(_dio.options, 'api/v1/my-follows/$id',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteFollowModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckInModel> patchCheckIn(prString) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckInModel>(Options(
                method: 'PATCH', headers: <String, dynamic>{}, extra: _extra)
            .compose(_dio.options, 'api/v1/tickets/checkin/?qr=$prString',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckInModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
