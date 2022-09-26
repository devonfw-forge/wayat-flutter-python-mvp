import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';

part 'contacts_page_controller.g.dart';

// ignore: library_private_types_in_public_api
class ContactsPageController = _ContactsPageController
    with _$ContactsPageController;

abstract class _ContactsPageController with Store {
  late RequestsController requestsController;
  final FriendsController friendsController;
  late SuggestionsController suggestionsController;

  static const int friendsPageIndex = 0;
  static const int requestsPageIndex = 1;
  static const int suggestionsPageIndex = 2;

  DateTime timeFriendsUpdate = DateTime(1970);
  DateTime timeRequestsUpdate = DateTime(1970);
  DateTime timeSuggestionsUpdate = DateTime(1970);

  Duration maxTimeBetweenUpdates = const Duration(seconds: 30);

  @observable
  ContactsCurrentPages currentPage = ContactsCurrentPages.contacts;

  _ContactsPageController(
      {FriendsController? friendsController,
      RequestsController? requestsController,
      SuggestionsController? suggestionsController})
      : friendsController = friendsController ?? FriendsController() {
    this.requestsController = requestsController ??
        RequestsController(friendsController: this.friendsController);
    this.suggestionsController = suggestionsController ??
        SuggestionsController(
            friendsController: this.friendsController,
            requestsController: this.requestsController);
  }

  TextEditingController searchBarController = TextEditingController();

  @action
  void setContactsCurrentPage(ContactsCurrentPages currentPage) {
    this.currentPage = currentPage;
  }

  @action
  void setSearchBarText(String text) {
    friendsController.setTextFilter(text);
    requestsController.setTextFilter(text);
    suggestionsController.setTextFilter(text);
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
