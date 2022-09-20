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
    if (results.isNotEmpty) {
      Address firstAddress = results.first;
      String number = firstAddress.addressComponents.first.shortName;
      String street = "";
      if (firstAddress.addressComponents.length > 1) {
        street = firstAddress.addressComponents.elementAt(1).shortName;
      }
      String city = "";
      if (firstAddress.addressComponents.length > 2) {
        city = firstAddress.addressComponents.elementAt(2).longName;
      }
      return "$street, $number, $city";
    } else {
      return "ERROR_ADDRESS";
    }
  }
}
