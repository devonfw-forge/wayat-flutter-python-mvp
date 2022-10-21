import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayat/services/location_listener/firestore_model/contact_ref_model.dart';
import 'package:wayat/services/location_listener/firestore_model/firestore_data_model.dart';

void main() async {
  test('fromMap is correct', () {
    Map<String, dynamic> modelMap = {
      'active': true,
      'contact_refs': [
        {
          'uid': 'uid',
          'location': const GeoPoint(1.0, 1.0),
          'address': 'address',
          'last_updated': Timestamp.fromDate(DateTime(1970))
        },
        {
          'uid': 'uid2',
          'location': const GeoPoint(1.0, 1.0),
          'address': 'address',
          'last_updated': Timestamp.fromDate(DateTime(1970))
        },
      ]
    };
    expect(defaultDataModel(), FirestoreDataModel.fromMap(modelMap));
  });

  test('Operator == is correct', () {
    FirestoreDataModel dataModel = defaultDataModel(active: true);
    FirestoreDataModel partialCopy = defaultDataModel(active: false);
    FirestoreDataModel fullCopy = defaultDataModel(active: true);

    expect(dataModel, fullCopy);
    expect(dataModel == partialCopy, false);
  });

  test('hashCode is correct', () {
    FirestoreDataModel dataModel = defaultDataModel(active: true);
    FirestoreDataModel partialCopy = defaultDataModel(active: false);
    FirestoreDataModel fullCopy = defaultDataModel(active: true);

    expect(dataModel.hashCode, fullCopy.hashCode);
    expect(dataModel.hashCode == partialCopy.hashCode, false);
  });
}

FirestoreDataModel defaultDataModel({bool? active}) {
  return FirestoreDataModel(
      active: active ?? true,
      contactRefs: [defaultContactRef(), defaultContactRef(id: "uid2")]);
}

ContactRefModel defaultContactRef({String? id}) {
  return ContactRefModel(
      uid: id ?? 'uid',
      location: const GeoPoint(1.0, 1.0),
      address: 'address',
      lastUpdated: Timestamp.fromDate(DateTime(1970)));
}
