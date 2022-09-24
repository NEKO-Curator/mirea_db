// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      text: json['text'] as String?,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'text': instance.text,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://microsoft-translator-text.p.rapidapi.com/';
  }

  final diolib.Dio _dio;

  String? baseUrl;

  @override
  Future<String> translate(text) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'content-type': 'application/json',
      r'X-RapidAPI-Key': 'e0cfc51f6emshe3ad569772cd49ap1a4198jsn3e02d072de69',
      r'X-RapidAPI-Host': 'microsoft-translator-text.p.rapidapi.com',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(text.toJson());
    final _result =
        await _dio.fetch<String>(_setStreamType<String>(diolib.Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/json',
    )
            .compose(
              _dio.options,
              '/translate?to%5B0%5D=ru&api-version=3.0&profanityAction=NoAction&textType=plain',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  diolib.RequestOptions _setStreamType<T>(
      diolib.RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == diolib.ResponseType.bytes ||
            requestOptions.responseType == diolib.ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = diolib.ResponseType.plain;
      } else {
        requestOptions.responseType = diolib.ResponseType.json;
      }
    }
    return requestOptions;
  }
}
