import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';

class SentRequestsPage extends StatelessWidget {
  final RequestsController controller =
      GetIt.I.get<ContactsPageController>().requestsController;

  SentRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          const SizedBox(
            height: 10,
          ),
          sentRequestsList()
        ],
      ),
    );
  }

  Widget sentRequestsList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
      child: Observer(builder: (_) {
        List<Contact> requests = controller.sentRequests;
        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: requests.length,
            itemBuilder: (context, index) => ContactTile(
                  contact: requests[index],
                  textAction: TextButton(
                    onPressed: null,
                    child: Text(
                      appLocalizations.sentButtonTile,
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                  ),
                  iconAction: IconButton(
                    onPressed: () async =>
                        await controller.unsendRequest(requests[index]),
                    icon: const Icon(
                      Icons.close,
                      color: ColorTheme.primaryColor,
                    ),
                    splashRadius: 20,
                  ),
                ));
      }),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              splashRadius: 20,
              padding: EdgeInsets.zero,
              onPressed: () => GetIt.I
                  .get<ContactsPageController>()
                  .setviewSentRequests(false)),
          Observer(builder: (context) {
            int numRequests = controller.sentRequests.length;
            return Text(
              //"${appLocalizations.sentRequestsTitle} ($numRequests)",
              appLocalizations.sentRequestsTitle,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
            );
          }),
        ],
      ),
    );
  }
}
