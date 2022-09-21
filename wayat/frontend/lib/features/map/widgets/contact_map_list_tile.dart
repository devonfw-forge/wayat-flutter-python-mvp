import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/app_state/home_state/home_state.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:wayat/features/map/widgets/contact_image.dart';
import 'package:wayat/lang/app_localizations.dart';

class ContactMapListTile extends StatelessWidget {
  final ContactLocation contact;
  const ContactMapListTile({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ContactImage(
          imageUrl: contact.imageUrl,
          radius: 22,
        ),
        const SizedBox(
          width: 15,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              addressFuture(),
              const SizedBox(
                height: 5,
              ),
              Text(
                timeago.format(contact.lastUpdated,
                    locale: Localizations.localeOf(context).languageCode),
                style: const TextStyle(fontSize: 17, color: Colors.black54),
              ),
              TextButton(
                onPressed: () => GetIt.I
                    .get<HomeState>()
                    .setSelectedContact(contact, "wayat"),
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Text(
                  appLocalizations.viewInformation,
                  style: const TextStyle(
                      color: ColorTheme.primaryColor, fontSize: 16),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Text addressFuture() {
    return Text(
      contact.address.toString(),
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 17, color: Colors.black54),
    );
  }
}
