import 'package:flutter/material.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/map/widgets/contact_image.dart';

class SuggestionsTile extends StatelessWidget {
  final Contact contact;
  final void Function()? onTap;
  const SuggestionsTile({required this.contact, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          ContactImage(imageUrl: contact.imageUrl, radius: 16),
          const SizedBox(
            width: 20,
          ),
          Text(
            contact.name,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
