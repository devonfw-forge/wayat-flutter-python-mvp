import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/google_maps_service/google_maps_service.dart';

class ContactMapListTile extends StatelessWidget {
  final ContactLocation contact;
  const ContactMapListTile({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(contact.imageUrl),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            addressFuture(),
            const SizedBox(
              height: 5,
            ),
            Text(
              timeago.format(contact.lastUpdated),
              style: const TextStyle(fontSize: 17, color: Colors.black54),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                appLocalizations.viewInformation,
                style: const TextStyle(
                    color: ColorTheme.primaryColor, fontSize: 16),
              ),
            )
          ],
        )
      ],
    );
  }

  FutureBuilder<String> addressFuture() {
    return FutureBuilder(
        future: GoogleMapsService.getAddressFromCoordinates(
            LatLng(contact.latitude, contact.longitude)),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: 250,
              child: Text(
                snapshot.data.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 17, color: Colors.black54),
              ),
            );
          } else {
            return Text(
              appLocalizations.loadingAddress,
              style: const TextStyle(fontSize: 17, color: Colors.black54),
            );
          }
        }));
  }
}
