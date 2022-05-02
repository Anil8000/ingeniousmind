// To parse this JSON data, do
//
//     final mainListResponse = mainListResponseFromJson(jsonString);

import 'dart:convert';

Map<String, MainListResponse> mainListResponseFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, MainListResponse>(k, MainListResponse.fromJson(v)));

String mainListResponseToJson(Map<String, MainListResponse> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class MainListResponse {
  MainListResponse({
    this.icao,
    this.iata,
    this.name,
    this.city,
    this.state,
    this.country,
    this.elevation,
    this.lat,
    this.lon,
    this.tz,
  });

  String? icao;
  String? iata;
  String? name;
  String? city;
  String? state;
  String? country;
  int? elevation;
  double? lat;
  double? lon;
  String? tz;

  factory MainListResponse.fromJson(Map<String, dynamic> json) => MainListResponse(
    icao: json["icao"] == null ? null : json["icao"],
    iata: json["iata"] == null ? null : json["iata"],
    name: json["name"] == null ? null : json["name"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    country: json["country"] == null ? null : json["country"],
    elevation: json["elevation"] == null ? null : json["elevation"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    tz: json["tz"] == null ? null : json["tz"],
  );

  Map<String, dynamic> toJson() => {
    "icao": icao == null ? null : icao,
    "iata": iata == null ? null : iata,
    "name": name == null ? null : name,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "country": country == null ? null : country,
    "elevation": elevation == null ? null : elevation,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
    "tz": tz == null ? null : tz,
  };
}
