import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';

void main() async {
  test('fromMap is correct', () {
    Map<String, dynamic> contactRefMap = {
      'uid': 'uid',
      'location': const GeoPoint(1.0, 1.0),
      'address': 'address',
      'last_updated': Timestamp.fromDate(DateTime(1970))
    };
    expect(defaultContactRef(), ContactRefModel.fromMap(contactRefMap));
  });

  test('Operator == works correctly', () {
    ContactRefModel contactRefModel = defaultContactRef();
    ContactRefModel partialCopy = defaultContactRef(id: 'id');
    ContactRefModel fullCopy = defaultContactRef();
    expect(contactRefModel != partialCopy, true);
    expect(contactRefModel == fullCopy, true);
  });

  test('hashCode is correct', () {
    ContactRefModel contactRefModel = defaultContactRef();
    ContactRefModel partialCopy = defaultContactRef(id: 'id');
    ContactRefModel fullCopy = defaultContactRef();
    expect(contactRefModel.hashCode != partialCopy.hashCode, true);
    expect(contactRefModel.hashCode, fullCopy.hashCode);
  });
}

ContactRefModel defaultContactRef({String? id}) {
  return ContactRefModel(
      uid: id ?? 'uid',
      location: const GeoPoint(1.0, 1.0),
      address: 'address',
      lastUpdated: Timestamp.fromDate(DateTime(1970)));
}
