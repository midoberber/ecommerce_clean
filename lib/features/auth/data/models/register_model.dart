class RegisterResponse {
  bool? success;
  String? message;
  Data? data;
  Meta? meta;

  RegisterResponse({this.success, this.message, this.data, this.meta});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    meta = json['meta'] != null ?  Meta.fromJson(json['meta']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  Photo? photo;

  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'] != null ?  Photo.fromJson(json['photo']) : null;
  }
}

class Photo {
  String? originalPlaceholder;
  String? cardPlaceholder;
  String? thumbPlaceholder;

  Photo(
      {this.originalPlaceholder, this.cardPlaceholder, this.thumbPlaceholder});

  Photo.fromJson(Map<String, dynamic> json) {
    originalPlaceholder = json['original_placeholder'];
    cardPlaceholder = json['card_placeholder'];
    thumbPlaceholder = json['thumb_placeholder'];
  }
}

class Meta {
  String? token;
  String? tokenType;
  int? expiresIn;

  Meta({this.token, this.tokenType, this.expiresIn});

  Meta.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }
}
