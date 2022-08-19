import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/features/contacts/widgets/contacts_section_title.dart';
import 'package:wayat/features/contacts/widgets/empty_page_message.dart';
import 'package:wayat/lang/app_localizations.dart';

class RequestsPage extends StatelessWidget {
  final RequestsController controller =
      GetIt.I.get<ContactsPageController>().requestsController;

  RequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.updateRequests();
    //complete column as to not cut the scrolls indicators
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          const SizedBox(
            height: 10,
          ),
          requestsList()
        ],
      ),
    );
  }

  Widget requestsList() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
      child: Observer(builder: (_) {
        List<Contact> requests = controller.filteredPendingRequests;
        if (requests.isEmpty) {
          return EmptyPageMessage(message: appLocalizations.noPendingRequests);
        } else {
          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) => ContactTile(
                    contact: requests[index],
                    textAction: TextButton(
                      child: Text(
                        appLocalizations.accept,
                        style: const TextStyle(
                            color: ColorTheme.primaryColor, fontSize: 18),
                      ),
                      onPressed: () async =>
                          await controller.acceptRequest(requests[index]),
                    ),
                    iconAction: IconButton(
                      onPressed: () async =>
                          await controller.rejectRequest(requests[index]),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black87,
                      ),
                      splashRadius: 20,
                    ),
                  ));
        }
      }),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Observer(builder: (context) {
            int numRequests = controller.filteredPendingRequests.length;
            return ContactsSectionTitle(
              text: "${appLocalizations.pendingRequestsTitle} ($numRequests)",
            );
          }),
          goToSentRequestsButton()
        ],
      ),
    );
  }

  Widget goToSentRequestsButton() {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      onTap: () =>
          GetIt.I.get<ContactsPageController>().setviewSentRequests(true),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(children: [
          Text(appLocalizations.sentButtonNavigation,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500)),
          const Icon(
            Icons.chevron_right,
            color: Colors.black54,
          )
        ]),
      ),
    );
  }
}
