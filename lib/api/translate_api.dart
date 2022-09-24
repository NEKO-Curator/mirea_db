//https://pub.dev/packages/retrofit
//flutter pub run build_runner build
//https://rapidapi.com/microsoft-azure-org-microsoft-cognitive-services/api/microsoft-translator-text
import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' as diolib;

part 'translate_api.g.dart';

@RestApi(baseUrl: "https://microsoft-translator-text.p.rapidapi.com/")
abstract class RestClient {
  factory RestClient(diolib.Dio dio, {String baseUrl}) = _RestClient;

  @POST(
      "/translate?to%5B0%5D=ru&api-version=3.0&profanityAction=NoAction&textType=plain")
  @Headers(<String, dynamic>{
    "content-type": "application/json",
    "X-RapidAPI-Key": "e0cfc51f6emshe3ad569772cd49ap1a4198jsn3e02d072de69",
    "X-RapidAPI-Host": "microsoft-translator-text.p.rapidapi.com"
  })
  Future<String> translate(@Body() Task text);
}

@JsonSerializable()
class Task {
  String? text;

  Task({this.text});

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

class TrResponse {
  DetectedLanguage? detectedLanguage;
  List<Translations>? translations;

  TrResponse({this.detectedLanguage, this.translations});

  TrResponse.fromJson(Map<String, dynamic> json) {
    detectedLanguage = json['detectedLanguage'] != null
        ? new DetectedLanguage.fromJson(json['detectedLanguage'])
        : null;
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detectedLanguage != null) {
      data['detectedLanguage'] = this.detectedLanguage!.toJson();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DetectedLanguage {
  String? language;
  int? score;

  DetectedLanguage({this.language, this.score});

  DetectedLanguage.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['score'] = this.score;
    return data;
  }
}

class Translations {
  String? text;
  String? to;

  Translations({this.text, this.to});

  Translations.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['to'] = this.to;
    return data;
  }
}
