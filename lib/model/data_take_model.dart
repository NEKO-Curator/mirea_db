import 'dart:developer';

class DataTake {
  DetectedLanguage? detectedLanguage;
  List<Translations>? translations;

  DataTake({this.detectedLanguage, this.translations});
  String getTranslationText() {
    // log('DataTake toString ${translations![0].toString()}');
    return translations?[0].toString().toString() ?? '';
  }

  DataTake.fromJson(Map<String, dynamic> json) {
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
  double? score;

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
  @override
  String toString() {
    return text.toString();
  }

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
