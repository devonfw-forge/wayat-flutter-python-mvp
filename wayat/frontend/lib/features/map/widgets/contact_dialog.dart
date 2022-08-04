import 'package:flutter/material.dart';
import 'package:wayat/common/widgets/buttons/filled_button.dart';
import 'package:wayat/domain/contact/contact.dart';

class ContactDialog extends StatelessWidget {
  final Contact contact;
  const ContactDialog({required this.contact, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.black, width: 1)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: (22),
                    backgroundColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(contact.imageUrl),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.displayName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contact.email,
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      contact.available.toString(),
                      style: const TextStyle(fontSize: 17),
                    )
                  ],
                ),
                Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () => {print("")},
                      borderRadius: BorderRadius.circular(1000),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(Icons.directions_outlined),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            CustomFilledButton(
                text: "View profile", onPressed: () {}, enabled: true),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ))
          ],
        ),
      ),
    );
  }
}
