import 'package:image_picker/image_picker.dart';
import 'package:wayat/domain/group/group.dart';

/// Communicates with the server to handle operations on the [Group] entity.
abstract class GroupsService {
  /// Gets the list of all [Group] entities of the current user.
  Future<List<Group>> getAll();

  /// Creates a [Group] with a profile picture.
  Future create(Group group, XFile? picture);

  /// Updates an existing [Group] and/or its profile picture.
  Future update(Group group, XFile? picture);

  /// Deletes the [Group] with the `groupId`.
  Future delete(String groupId);
}
