import 'package:json_annotation/json_annotation.dart';
import 'package:wayat/services/google_maps_service/address_response/address.dart';

part 'address_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddressResponse {
  List<Address> results;

  AddressResponse(this.results);

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  String firstValidAddress() {
    Address firstAddress = results.first;
    String number = firstAddress.addressComponents.first.shortName;
    String street = firstAddress.addressComponents[1].shortName;
    String city = firstAddress.addressComponents[2].longName;
    return "$street, $number, $city";
  }
}
