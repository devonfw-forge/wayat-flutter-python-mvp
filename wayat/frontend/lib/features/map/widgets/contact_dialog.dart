import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/common/widgets/buttons/circle_icon_button.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/google_maps_service/google_maps_service.dart';

class ContactDialog extends StatelessWidget {
  final ContactLocation contact;
  final BitmapDescriptor icon;
  const ContactDialog({required this.contact, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.black, width: 1)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [mapSection(context), dataSection(context)],
      ),
    );
  }

  Widget dataSection(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          children: [
            userInformation(),
            const SizedBox(
              height: 35,
            ),
            CustomFilledButton(
                text: appLocalizations.viewProfile,
                onPressed: () {},
                enabled: true),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => AutoRouter.of(context).pop(),
                child: Text(
                  appLocalizations.close,
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                ))
          ],
        ));
  }

  Widget userInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: (22),
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(contact.imageUrl),
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
                addressFuture(),
                Text(
                  timeago.format(contact.lastUpdated),
                  style: const TextStyle(fontSize: 17, color: Colors.black54),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          CircleIconButton(
            onPressed: () =>
                GoogleMapsService.openMaps(contact.latitude, contact.longitude),
            icon: Icons.directions_outlined,
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  FutureBuilder<String> addressFuture() {
    return FutureBuilder(
        future: GoogleMapsService.getAddressFromCoordinates(
            LatLng(contact.latitude, contact.longitude)),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data.toString(),
              style: const TextStyle(fontSize: 17, color: Colors.black54),
            );
          } else {
            return Text(
              appLocalizations.loadingAddress,
              style: const TextStyle(fontSize: 17, color: Colors.black54),
            );
          }
        }));
  }

  Widget mapSection(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          googleMap(),
          closeIconButton(context),
        ],
      ),
    );
  }

  Widget closeIconButton(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.topEnd,
        padding: const EdgeInsets.all(15),
        child: CircleIconButton(
          onPressed: () => {AutoRouter.of(context).pop()},
          icon: Icons.close,
          backgroundColor: Colors.white,
        ));
  }

  Widget googleMap() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5), topRight: Radius.circular(5)),
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black, width: 1))),
        child: GoogleMap(
          zoomControlsEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition: CameraPosition(
              target: LatLng(contact.latitude, contact.longitude), zoom: 16),
          markers: {
            Marker(
                markerId: MarkerId(contact.name),
                position: LatLng(contact.latitude, contact.longitude),
                icon: icon)
          },
        ),
      ),
    );
  }
}
