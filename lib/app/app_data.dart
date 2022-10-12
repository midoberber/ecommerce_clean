// ignore_for_file: unnecessary_cast

enum AppState {
  uninitialized,
  authenticated,
  unauthenticated,
  authenticating,
  notCompleted,
  notVerified,
  notSeenTutorial,
  notselectLang,
  guest,
}

class AppData {
  final String? token;
  final String? languageCode;
  final bool? isCompleted;
  final bool? isVerfied;
  final String? id;
  final String? displayName;
  final String? photoUrl;
  final bool? isSeenTutorial;
  final bool? isGuestUser;
  final bool? isSelectLang;
  final String? email;
  final String? phone;
  final String? typeUser;
  final String? verficationCode;

  AppData({
    this.typeUser,
    this.isSelectLang,
    this.isGuestUser,
    this.isSeenTutorial,
    this.token,
    this.id,
    this.displayName,
    this.photoUrl,
    this.languageCode,
    this.isCompleted,
    this.email,
    this.phone,
    this.isVerfied,
    this.verficationCode,
  });

  dynamic toJson() => {
        "token": token,
        "languageCode": languageCode,
        "isGuestUser": isGuestUser,
        "isCompleted": isCompleted,
        "id": id,
        "displayName": displayName,
        "photoUrl": photoUrl,
        "isVerfied": isVerfied,
        "isSeenTutorial": isSeenTutorial,
        "isSelectLang": isSelectLang,
        "email": email,
        "phone": phone,
        "typeUser": typeUser,
        "verficationCode": verficationCode,
      };
//update the crunnet user data
  AppData copyWith({
    bool? isCompleteed,
    String? langCode,
    String? name,
    String? userId,
    String? photo,
    String? emailCopy,
    String? phoneCopy,
    String? tokenCopy,
    bool? isvervie,
    bool? seenTutorial,
    bool? isGuestUserCopy,
    bool? selectLang,
    String? typeUserCopy,
    String? verficationCodeCopy,
  }) {
    return AppData(
        isCompleted: isCompleteed ?? isCompleted,
        languageCode: langCode ?? languageCode,
        displayName: name ?? displayName,
        token: tokenCopy ?? token,
        id: userId ?? id,
        photoUrl: photo ?? photoUrl,
        isVerfied: isvervie ?? isVerfied,
        isSeenTutorial: seenTutorial ?? isSeenTutorial,
        isSelectLang: selectLang ?? isSelectLang,
        isGuestUser: isGuestUserCopy ?? isGuestUser,
        email: emailCopy ?? email,
        phone: phoneCopy ?? phone,
        typeUser: typeUserCopy ?? typeUser,
        verficationCode: verficationCodeCopy ?? verficationCode);
  }

  static AppData fromJson(Map<String, dynamic> json) {
    return AppData(
      languageCode: (json['languageCode'] ?? "" as String),
      isCompleted: (json['isCompleted'] ?? false as bool),
      token: (json['token'] ?? "" as String),
      id: (json['id'] ?? "" as String),
      displayName: (json['displayName'] ?? "" as String),
      photoUrl: (json['photoUrl'] ?? "" as String),
      email: (json['email'] ?? "" as String),
      phone: (json['phone'] ?? "" as String),
      isVerfied: (json['isVerfied'] ?? false as bool),
      isSeenTutorial: (json['isSeenTutorial'] ?? false as bool),
      isSelectLang: (json['isSelectLang'] ?? false as bool),
      typeUser: (json['typeUser'] ?? "" as String),
      isGuestUser: (json['isGuestUser'] ?? false as bool),
      verficationCode: (json['verficationCode'] ?? "" as String),
    );
  }
}
