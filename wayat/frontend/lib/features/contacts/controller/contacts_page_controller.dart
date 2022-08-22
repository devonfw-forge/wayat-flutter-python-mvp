import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';

part 'contacts_page_controller.g.dart';

// ignore: library_private_types_in_public_api
class ContactsPageController = _ContactsPageController
    with _$ContactsPageController;

abstract class _ContactsPageController with Store {
  late RequestsController requestsController;
  late FriendsController friendsController;
  late SuggestionsController suggestionsController;

  _ContactsPageController() {
    friendsController = FriendsController();
    // Requests controller needs access to the friends controller to
    // be able to update the contacts if a request is accepted
    requestsController = RequestsController(friendsController);
    // Suggestions controller needs access to the friends and friendscontroller to
    // be able to filter the imported address book contacts from the
    // alreaady added wayat contacts without making extra REST calls
    suggestionsController = SuggestionsController(friendsController, requestsController);
  }

  TextEditingController searchBarController = TextEditingController();

  @observable
  bool viewSentRequests = false;

  @action
  void setviewSentRequests(bool view) {
    viewSentRequests = view;
  }

  @action
  void setSearchBarText(String text) {
    friendsController.setTextFilter(text);
    suggestionsController.setTextFilter(text);
    requestsController.setTextFilter(text);
  }
}
