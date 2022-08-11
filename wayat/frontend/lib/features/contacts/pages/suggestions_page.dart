import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';

class SuggestionsPage extends StatelessWidget {
  final SuggestionsController controller = SuggestionsController();

  SuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.updateSuggestedContacts();
    //The paddings are placed individually on each item instead of on the
    //complete column as to not cut the scrolls indicators
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              child: Text(
                "ADD YOUR CONTACTS",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
            child: Observer(builder: (context) {
              List<Contact> contacts = controller.suggestedContacts;

              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => ContactTile(
                        contact: contacts[index],
                        iconAction: IconButton(
                          onPressed: () =>
                              controller.sendRequest(contacts[index]),
                          icon: const Icon(
                            Icons.close,
                            color: ColorTheme.primaryColor,
                          ),
                          splashRadius: 20,
                        ),
                      ));
            }),
          )
        ],
      ),
    );
  }
}
