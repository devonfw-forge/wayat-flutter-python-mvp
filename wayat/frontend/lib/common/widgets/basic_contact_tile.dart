import 'package:flutter/material.dart';
import 'package:wayat/domain/contact/contact.dart';

/// Tile showing name and photo of the contact
class BasicContactTile extends StatelessWidget {
  /// Contact information which containes [Contact.name] and [Contact.imageUrl]
  final Contact contact;

  const BasicContactTile({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double nameSpace = 0.65;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  radius: 13,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(contact.imageUrl)),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * nameSpace),
                child: Text(
                  contact.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
