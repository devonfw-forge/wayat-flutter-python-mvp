import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';
import 'package:wayat/lang/app_localizations.dart';

/// Request sent to other user screen
class SentRequestsPage extends StatelessWidget {
  /// Business logic controller
  final RequestsController controller =
      GetIt.I.get<ContactsPageController>().requestsController;

  SentRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/contacts/requests');
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: header(context)),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: sentRequestsList())
          ],
        ),
      ),
    );
  }

  /// Returns widget with the sent request list of contact filtered by the query in searchbar
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

  /// Returns a widget containing an arrow to navigate to previous page
  /// and the title
  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            splashRadius: 20,
            padding: EdgeInsets.zero,
            onPressed: () => context.go('/contacts/requests'),
          ),
          Text(
            appLocalizations.sentRequestsTitle,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
