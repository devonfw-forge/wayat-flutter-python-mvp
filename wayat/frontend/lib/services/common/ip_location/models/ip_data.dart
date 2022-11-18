import 'package:json_annotation/json_annotation.dart';

part 'ip_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class IPData {
  final String status;
  final String country;
  final String countryCode;
  final String region;
  final String regionName;
  final String city;
  final String zip;
  final double lat;
  final double lon;
  final String timezone;
  final String isp;
  final String org;
  final String welcomeAs;
  final String query;

  IPData(
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.welcomeAs,
    this.query
  );

  factory IPData.fromJson(Map<String, dynamic> json) =>
      _$IPDataFromJson(json);

  Map<String, dynamic> toJson() {
    return _$IPDataToJson(this);
  }
}
