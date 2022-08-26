import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/common/widgets/buttons/circle_icon_button.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wayat/features/contact_profile/controller/contact_profile_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/google_maps_service/google_maps_service.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class ContactProfilePage extends StatelessWidget {
  Contact contact;

  /// This is required because this page can be accessed from multiple places
  /// and the design indicates to which page the user will return to when going back
  final String navigationSource;
  final ContactProfileController controller;

  ContactProfilePage(
      {required this.contact,
      required this.navigationSource,
      ContactProfileController? controller,
      Key? key})
      : controller = controller ?? ContactProfileController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactLocation? contactLocated = GetIt.I
        .get<UserStatusState>()
        .contacts
        .where((element) => element.id == contact.id)
        .firstOrNull;
    bool canBeLocated = contactLocated != null;
    if (canBeLocated) {
      contact = contactLocated;
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40), child: CustomAppBar()),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          appBar(),
          mapSection(context, canBeLocated),
          dataSection(context, canBeLocated)
        ],
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                GetIt.I.get<HomeState>().setSelectedContact(null, "");
              },
              icon: const Icon(Icons.arrow_back)),
          Text(
            navigationSource,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          )
        ],
      ),
    );
  }

  Widget dataSection(BuildContext context, bool canBeLocated) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: (22),
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(contact.imageUrl),
                ),
              )),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                (contact is ContactLocation)
                    ? locationInfo()
                    : Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          appLocalizations.contactProfileNotSharingLocation,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black54),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          (canBeLocated)
              ? CircleIconButton(
                  onPressed: () =>
                      controller.openMaps(contact as ContactLocation),
                  icon: Icons.directions_outlined,
                  backgroundColor: Colors.transparent,
                )
              : Container()
        ],
      ),
    );
  }

  Column locationInfo() {
    ContactLocation locatedContact = contact as ContactLocation;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          appLocalizations.contactProfileSharingLocationWithYou,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorTheme.primaryColor,
              fontSize: 17),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          locatedContact.address.toString(),
          style: const TextStyle(fontSize: 17, color: Colors.black54),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${appLocalizations.contactProfileLastUpdated} ${timeago.format(locatedContact.lastUpdated)}",
          style: const TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ],
    );
  }

  Widget mapSection(BuildContext context, bool canBelocated) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          //Border radius is both in this container as well as in the map
          //and the no location message container, because if not
          //the content does not look rounded as well as the border
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: (canBelocated)
          ? googleMap(contact as ContactLocation)
          : locationNotAvailableMessage(context),
    );
  }

  Widget locationNotAvailableMessage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ColorTheme.secondaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      height: MediaQuery.of(context).size.height * 0.09,
      child: Center(
        child: Text(
          appLocalizations.contactProfileLocationNotAvailable,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }

  Widget googleMap(ContactLocation contact) {
    return FutureBuilder(
        future: controller.getMarkerImage(contact),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(contact.latitude, contact.longitude),
                      zoom: 16),
                  markers: {
                    Marker(
                        markerId: MarkerId(contact.name),
                        position: LatLng(contact.latitude, contact.longitude),
                        icon: snapshot.data as BitmapDescriptor)
                  },
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
