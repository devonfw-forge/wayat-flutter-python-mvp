import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/features/contacts/controller/page_controller/contacts_page_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/widgets/contact_tile.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Observer(builder: (context) {
                  int numRequests = controller.pendingRequests.length;
                  return Text(
                    "FRIENDS REQUESTS ($numRequests)",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  );
                }),
                InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  onTap: () => GetIt.I
                      .get<ContactsPageController>()
                      .setviewSentRequests(true),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(children: const [
                      Text("SENT",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500)),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.black54,
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
            child: Observer(builder: (context) {
              List<Contact> requests = controller.pendingRequests;

              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: requests.length,
                  itemBuilder: (context, index) => ContactTile(
                        contact: requests[index],
                        textAction: TextButton(
                          child: const Text(
                            "Accept",
                            style: TextStyle(
                                color: ColorTheme.primaryColor, fontSize: 18),
                          ),
                          onPressed: () =>
                              controller.acceptRequest(requests[index]),
                        ),
                        iconAction: IconButton(
                          onPressed: () =>
                              controller.rejectRequest(requests[index]),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black87,
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
