class FirestorePosModel {
  String? title;
  String? subtitle;
  String? price;

  FirestorePosModel({this.title, this.subtitle, this.price});

  FirestorePosModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['price'] = price;
    return data;
  }
}
