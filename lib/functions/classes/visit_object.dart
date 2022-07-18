class Visit{
  final int id;
  final String cityName;
  final String cityCode;
  final String continent;

  Visit({this.id, this.cityName, this.cityCode, this.continent});

  factory Visit.fromMap(Map<String, dynamic> json) => Visit(
    id: json['id'],
    cityName: json['cityName'],
    cityCode: json['cityCode'],
    continent: json['continent']
  );

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'cityName' : cityName,
      'cityCode' : cityCode,
      'continent' : continent
    };
  }

}











