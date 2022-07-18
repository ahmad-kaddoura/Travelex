class LikedCity {
  final int id;
  final String cityName;
  final String imgUrl;
  final String streetView;
  final String location;

  LikedCity({this.id, this.cityName, this.imgUrl, this.streetView, this.location});

  factory LikedCity.fromMap(Map<String, dynamic> json) =>
      LikedCity(
        id: json['id'],
        cityName: json['cityName'],
        imgUrl: json['imgUrl'],
        streetView: json['streetView'],
        location: json['location']
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cityName': cityName,
      'imgUrl': imgUrl,
      'streetView': streetView,
      'location': location
    };
  }
}