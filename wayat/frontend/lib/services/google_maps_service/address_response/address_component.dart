import 'package:json_annotation/json_annotation.dart';

part 'address_component.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressComponent {
  final String longName;
  final String shortName;
  final List<String> types;

  AddressComponent(this.longName, this.shortName, this.types);

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);

  Map<String, dynamic> toJson() {
    return _$AddressComponentToJson(this);
  }
}
