/// Defines the relative URLs for the server endpoints.
class APIContract {
  /*
   * ============ USER ============ *
   */
  /// [GET] Returns User profile
  ///
  /// [POST] Updates User
  ///
  /// [DELETE] Delete User account
  static const String userProfile = "users/profile";

  /// [POST] Updates user profile picture (requires Multipart File)
  static const String userProfilePicture = "users/profile/picture";

  /// [POST] Returns wayat accounts based on a list of phones
  static const String findByPhone = "users/find-by-phone";

  /// [POST] Updates share location and do not disturb preferences
  static const String preferences = "users/preferences";

  /*
   * ============ CONTACT ============ *
   */

  /// [POST] Sends friends requests to a list of contacts
  static const String addContact = "contacts/add";

  /// [GET] Returns the list of contacts for a user
  ///
  /// [DELETE] Deletes a contact (Requires ID appended in URL)
  static const String contacts = "contacts";

  /// [GET] Returns sent and received friendship requests
  ///
  /// [POST] Accepts or denies a friend request
  static const String friendRequests = "contacts/requests";

  /// [DELETE] Cancels a sent friend request (Requires ID appended)
  static const String sentFriendRequests = "contacts/requests/sent";

  /*
   * ============ GROUP ============ *
   */

  /// [GET] Returns this user's groups
  ///
  /// [GET] Returns a specific group (Required ID appended in the URL)
  ///
  /// [POST] Creates a group
  ///
  /// [PUT] Updates a group (Required ID appended in the URL)
  ///
  /// [DELETE] Deletes a group (Required ID appended in the URL)
  static const String groups = "groups";

  /// [POST] Updates the group's picture (Required ID appended in the URL)
  static const String groupPicture = "groups/picture";

  /*
   * ============ MAP ============ *
   */
  /// [POST] Updates your location
  static const String updateLocation = "map/update-location";

  /// [POST] Notifies if your map is open or closed
  static const String updateMap = "map/update-map";
}
