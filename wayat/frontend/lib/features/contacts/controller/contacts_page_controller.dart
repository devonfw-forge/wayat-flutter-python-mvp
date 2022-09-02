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

  static const int friendsPageIndex = 0;
  static const int requestsPageIndex = 1;
  static const int suggestionsPageIndex = 2;

  DateTime timeFriendsUpdate = DateTime(1970);
  DateTime timeRequestsUpdate = DateTime(1970);
  DateTime timeSuggestionsUpdate = DateTime(1970);

  Duration maxTimeBetweenUpdates = const Duration(seconds: 30);

  _ContactsPageController() {
    friendsController = FriendsController();
    // Requests controller needs access to the friends controller to
    // be able to update the contacts if a request is accepted
    requestsController =
        RequestsController(friendsController: friendsController);
    // Suggestions controller needs access to the friends and friendscontroller to
    // be able to filter the imported address book contacts from the
    // alreaady added wayat contacts without making extra REST calls
    suggestionsController = SuggestionsController(
        friendsController: friendsController,
        requestsController: requestsController);
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

  void updateTabData(int index) {
    switch (index) {
      case friendsPageIndex:
        if (timeFriendsUpdate.difference(DateTime.now()).abs() >=
            maxTimeBetweenUpdates) {
          friendsController.updateContacts();
          timeFriendsUpdate = DateTime.now();
        }
        break;
      case requestsPageIndex:
        if (timeRequestsUpdate.difference(DateTime.now()).abs() >=
            maxTimeBetweenUpdates) {
          requestsController.updateRequests();
          timeRequestsUpdate = DateTime.now();
        }
        break;
      case suggestionsPageIndex:
        if (timeSuggestionsUpdate.difference(DateTime.now()).abs() >=
            maxTimeBetweenUpdates) {
          suggestionsController.updateSuggestedContacts();
          timeSuggestionsUpdate = DateTime.now();
        }
        break;
    }
  }
}
