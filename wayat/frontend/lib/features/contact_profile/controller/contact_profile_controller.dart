import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/services/common/api_contract/api_contract.dart';
import 'package:wayat/services/common/http_provider/http_provider.dart';
import 'package:wayat/services/google_maps_service/google_maps_service.dart';
import 'package:wayat/services/image_service/image_service.dart';

part 'contact_profile_controller.g.dart';

// ignore: library_private_types_in_public_api
class ContactProfileController = _ContactProfileController
    with _$ContactProfileController;

abstract class _ContactProfileController with Store {
  final ImageService _imageService = ImageService();
  
  final HttpProvider httpProvider = GetIt.I.get<HttpProvider>();

  @observable
  bool shareLocationToContact = true;

  Future<BitmapDescriptor> getMarkerImage(Contact contact) async {
    return (await _imageService.getBitmapsFromUrl([contact.imageUrl]))
        .values
        .first;
  }

  void openMaps(ContactLocation contact) {
    GoogleMapsService.openMaps(contact.latitude, contact.longitude);
  }

  @action
  Future<void> setShareLocationToContact(bool shareLocationToContact, Contact contact) async {
    if (shareLocationToContact != contact.shareLocation) {
      httpProvider.sendPostRequest('${APIContract.contacts}/${contact.id}', 
        {
          'share_location': shareLocationToContact
        }
      );
    }
    this.shareLocationToContact = shareLocationToContact;
    contact.shareLocation = shareLocationToContact;
  }
}
