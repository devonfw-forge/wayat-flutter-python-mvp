import 'package:cloud_firestore/cloud_firestore.dart';

class DbService {
  late FirebaseFirestore db;

  DbService() {
    db = FirebaseFirestore.instance;
  }
}
