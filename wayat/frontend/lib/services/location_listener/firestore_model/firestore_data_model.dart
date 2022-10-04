// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';
import 'package:wayat/services/utils/list_utils_service.dart';

/// Represents the status object present in Firestore for "realtime" location
/// updates of the user's contacts.
class FirestoreDataModel {
  /// Whether the user should share their location actively (more updates) or passively.
  ///
  /// This depends on whether the current user is being seen by other
  /// contacts in their respective maps.
  final bool active;

  /// The list of positional data for the contacts currently sharing their location.
  ///
  /// For more information look at the [ContactRefModel] class.
  final List<ContactRefModel> contactRefs;

  FirestoreDataModel({
    required this.active,
    required this.contactRefs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'active': active,
      'contactRefs': contactRefs.map((x) => x.toMap()).toList(),
    };
  }

  factory FirestoreDataModel.fromMap(Map<String, dynamic> map) {
    return FirestoreDataModel(
      active: map['active'] as bool,
      contactRefs: List<ContactRefModel>.from(
        (map['contact_refs']).map<ContactRefModel>(
          (x) => ContactRefModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FirestoreDataModel.fromJson(String source) =>
      FirestoreDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant FirestoreDataModel other) {
    if (identical(this, other)) return true;

    return other.active == active &&
        ListUtilsService.haveDifferentElements(other.contactRefs, contactRefs);
  }

  @override
  int get hashCode => active.hashCode ^ contactRefs.hashCode;
}
