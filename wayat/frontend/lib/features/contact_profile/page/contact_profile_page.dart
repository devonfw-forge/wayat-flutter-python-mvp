import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/navigation/home_nav_state/home_nav_state.dart';
import 'package:wayat/common/widgets/appbar/appbar.dart';
import 'package:wayat/common/widgets/buttons/circle_icon_button.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wayat/features/contact_profile/controller/contact_profile_controller.dart';
import 'package:wayat/lang/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:wayat/services/google_maps_service/google_maps_service.dart';

/// Detailed view of a Contact Profile
// ignore: must_be_immutable
class ContactProfilePage extends StatelessWidget {
  /// Contact viewed in detail.
  Contact contact;

  /// Name of previous page of the current one.
  ///
  /// This is required because this page can be accessed from multiple places
  /// and the design indicates to which page the user will return to when going back
  final String navigationSource;

  /// Controller including the logig business of this page
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
    controller.setShareLocationToContact(contact.shareLocationTo, contact);
    ContactLocation? contactLocated = GetIt.I
        .get<LocationListener>()
        .receiveLocationState
        .contacts
        .where((element) => element.id == contact.id)
        .firstOrNull;
    bool canBeLocated = contactLocated != null;
    if (canBeLocated) {
      contact = contactLocated;
    }

    return WillPopScope(
      onWillPop: () async {
        goBack(context);
        return true;
      },
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(40), child: CustomAppBar()),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              appBar(context),
              mapSection(context, canBeLocated),
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: dataSection(context, canBeLocated)),
              divider(),
              ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: shareMyLocationRow())
            ],
          ),
        ),
      ),
    );
  }

  /// Returns an appBar with a return arrow to previous page
  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () => goBack(context),
              icon: const Icon(Icons.arrow_back)),
          Text(
            (navigationSource == '/contacts/friends') ? 'Contacts' : 'wayat',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
          )
        ],
      ),
    );
  }

  void goBack(BuildContext context) {
    GetIt.I.get<HomeNavState>().setSelectedContact(null);
    context.go(navigationSource);
  }

  /// Returns a widget which includes a switch to enable/disable sharing location with a contact
  Widget shareMyLocationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.shareMyLocation,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 18),
          ),
          Observer(builder: (context) {
            bool enabled = controller.shareLocationToContact;
            return CustomSwitch(
              value: enabled,
              onChanged: (newValue) {
                controller.setShareLocationToContact(newValue, contact);
              },
            );
          })
        ],
      ),
    );
  }

  /// Returns a widget containing username and its location and time ago
  ///
  /// If location it's not available return a text saying that is not sharing location
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
                    ? locationInfo(context)
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

  /// Simple line divider
  Divider divider() {
    return const Divider(
      endIndent: 15,
      indent: 15,
      height: 1,
      thickness: 1,
    );
  }

  /// Return a widget containing the addres location and the time ago in this location
  Column locationInfo(BuildContext context) {
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
          "${appLocalizations.contactProfileLastUpdated} ${timeago.format(locatedContact.lastUpdated, locale: Localizations.localeOf(context).languageCode)}",
          style: const TextStyle(fontSize: 17, color: Colors.black54),
        ),
      ],
    );
  }

  /// Returns a widget containing an image of current location of user or a message saying that is not sharing location
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
          ? googleMap(contact as ContactLocation, context)
          : locationNotAvailableMessage(context),
    );
  }

  /// Returns a widget containing the message that the user is not sharing location
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

  /// Returns the image of google map of detailew view of contact location
  Widget googleMap(ContactLocation contact, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                GoogleMapsService.getStaticMapImageFromCoords(
                    LatLng(contact.latitude, contact.longitude)),
                fit: BoxFit.cover,
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(contact.imageUrl),
            )
          ],
        ),
      ),
    );
  }
}
