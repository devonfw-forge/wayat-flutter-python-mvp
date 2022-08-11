import 'package:mobx/mobx.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';

part 'contacts_page_controller.g.dart';

class ContactsPageController = _ContactsPageController
    with _$ContactsPageController;

abstract class _ContactsPageController with Store {
  //This controller is instanced here because it is accesed both from
  //the requests page and the sent requests page, which are in a complex
  //situation in terms of navigation. I considered it a better solution
  //to accessed from this global controller rather than register another
  //singleton
  RequestsController requestsController = RequestsController();

  @observable
  bool viewSentRequests = false;

  @action
  void setviewSentRequests(bool view) {
    viewSentRequests = view;
  }
}
