class APIContract {
  /*
   * USER 
   */
  /// [GET] Returns User profile
  ///
  /// [POST] Updates User
  static const String userProfile = "users/profile";

  /// [POST] Updates user profile picture (requires Multipart File)
  static const String userProfilePicture = "users/profile/picture";

  /// [POST] Returns wayat accounts based on a list of phones
  static const String findByPhone = "users/find-by-phone";

  /// [POST] Sends friends requests to a list of contacts
  static const String addContact = "users/add-contact";

  /// [POST] Updates share location and do not disturb preferences
  static const String preferences = "users/preferences";

  /// [GET] Returns the list of contacts for a user
  ///
  /// [DELETE] Deletes a contact (Requires ID appended in URL)
  static const String contacts = "users/contacts";

  /// [GET] Returns sent and received friendship requests
  ///
  /// [POST] Accepts or denies a friend request
  static const String friendRequests = "users/friend-requests";

  /// [DELETE] Cancels a sent friend request (Requires ID appended)
  static const String sentFriendRequests = "users/friend-requests/sent";

  /*
   * MAP 
   */
  /// [POST] Updates your location
  static const String updateLocation = "map/update-location";

  /// [POST] Notifies if your map is open or closed
  static const String updateMap = "map/update-map";
}
