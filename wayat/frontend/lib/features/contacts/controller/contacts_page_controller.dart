import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:wayat/features/contacts/controller/friends_controller/friends_controller.dart';
import 'package:wayat/features/contacts/controller/navigation/contacts_current_pages.dart';
import 'package:wayat/features/contacts/controller/requests_controller/requests_controller.dart';
import 'package:wayat/features/contacts/controller/suggestions_controller/suggestions_controller.dart';

part 'contacts_page_controller.g.dart';

/// Controller containing business logic for Friends tab inside contacts page
// ignore: library_private_types_in_public_api
class ContactsPageController = _ContactsPageController
    with _$ContactsPageController;

/// Base Controller for friends tab using MobX
abstract class _ContactsPageController with Store {
  /// Requests Controller to access its logic
  late RequestsController requestsController;

  /// Friends Controller to access its logic
  final FriendsController friendsController;

  /// Suggestions Controller to access its logic
  late SuggestionsController suggestionsController;

  /// Index for friends page
  static const int friendsPageIndex = 0;

  /// Index for requests page
  static const int requestsPageIndex = 1;

  /// Index for suggestions page
  static const int suggestionsPageIndex = 2;

  /// Time of lastUpdate of friends list
  DateTime timeFriendsUpdate = DateTime(1970);

  /// Time of lastUpdate of requests list
  DateTime timeRequestsUpdate = DateTime(1970);

  /// Time of lastUpdate of suggestions list
  DateTime timeSuggestionsUpdate = DateTime(1970);

  /// Min time between any request of friends, requests or suggestions
  Duration maxTimeBetweenUpdates = const Duration(seconds: 3);

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

  /// Text controller for searchbar
  TextEditingController searchBarController = TextEditingController();

  /// Sets the value of the searchbar to the text filter for friends, requests
  /// and suggestions page
  @action
  void setSearchBarText(String text) {
    friendsController.setTextFilter(text);
    requestsController.setTextFilter(text);
    suggestionsController.setTextFilter(text);
  }

  /// Updates the data of the selected tab if a duration of
  /// [maxTimeBetweenUpdates] has passed
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
