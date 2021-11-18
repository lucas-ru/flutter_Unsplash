import 'dart:ui';

class UnsplashImage {

  String id;
  String? description;
  String? regularUrl;
  String? fullUrl;
  String? rawUrl; //For downloading image only
  String? userName; //Attribution to the photographer
  String? userProfileUrl; //Photographer's profile
  String? userProfileImage; //Photographer's profile image
  int? likes;
  String? blurHash; //Optional
  String? downloadLocation; //Optional
  String? color;

  UnsplashImage(
      this.id,
      this.description,
      this.regularUrl,
      this.fullUrl,
      this.rawUrl,
      this.userName,
      this.userProfileUrl,
      this.userProfileImage,
      this.likes,
      this.blurHash,
      this.downloadLocation,
      this.color
      ); //Optional



  factory UnsplashImage.fromJson(Map<String, dynamic> json){
    return UnsplashImage(
        json['id'],
        json['description'],
        json['urls']['regular'],
        json['urls']['full'],
        json['urls']['raw'],
        json['user']['username'],
        json['user']['links']['self'],
        json['user']['portfolio_url'],
        json['likes'],
        json['blurHash'],
        json['downloadLocation'],
        json['color']
    );



  }

  @override
  String toString() {
    return 'UnsplashImage{id: $id, description: $description, regularUrl: $regularUrl, fullUrl: $fullUrl, rawUrl: $rawUrl, userName: $userName, userProfileUrl: $userProfileUrl, userProfileImage: $userProfileImage, likes: $likes, blurHash: $blurHash, downloadLocation: $downloadLocation, color: $color}';
  }
}
