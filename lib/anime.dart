import 'dart:convert';

AnimeList animeFromJson(String str) => AnimeList.fromJson(json.decode(str));

String animeToJson(AnimeList data) => json.encode(data.toJson);

class AnimeList {
  String name;
  String epsNumber;
  String lastSeen;

  AnimeList({this.name, this.epsNumber, this.lastSeen});

  factory AnimeList.fromJson(Map<String, dynamic> json) => AnimeList(
        name: json["name"],
        epsNumber: json["epsNumber"],
        lastSeen: json["lastSeen"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "epsNumber": epsNumber,
        "lastSeen": lastSeen,
      };
}
