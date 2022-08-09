import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppController with _$AppController;

abstract class _AppController with Store {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  _AppController() {
    final docRef = db.collection("spike").doc("counter_unprotected");
    docRef.snapshots().listen(
          (event) => setCounter(event.data()!["value"]),
          onError: (error) => print("Listen failed: $error"),
        );
  }

  @observable
  int counter = 0;

  @action
  void setCounter(int newValue) {
    counter = newValue;
  }
}
