import 'package:wayat/domain/contact/contact.dart';

/// Communicates with the server to handle operations on the [Contact] entity.
abstract class ContactService {
  /// Returns the list of [Contact] entities of the current user.
  Future<List<Contact>> getAll();

  /// Sends a friend request to all [Contact] entities in the `contacts` list.
  ///
  /// Should be moved to [RequestsService] in future iterations.
  Future<void> sendRequests(List<Contact> contacts);

  /// Returns the list of [Contact] entities registered in wayat with the
  /// phone numbers present in `importedContacts`.
  Future<List<Contact>> getFilteredContacts(List<String> importedContacts);

  /// Removes the `contact` argument from the [Contact] list of the current user.
  Future<bool> removeContact(Contact contact);
}