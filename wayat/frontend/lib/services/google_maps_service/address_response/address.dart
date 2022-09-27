import 'package:json_annotation/json_annotation.dart';
import 'package:wayat/services/google_maps_service/address_response/address_component.dart';

part 'address.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Address {
  List<AddressComponent> addressComponents;
  String formattedAddress;

  Address(this.addressComponents, this.formattedAddress);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() {
    return _$AddressToJson(this);
  }
}
