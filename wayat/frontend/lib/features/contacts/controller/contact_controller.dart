import 'package:mobx/mobx.dart';
import 'package:wayat/domain/contact/contact.dart';
import 'package:wayat/services/contact/contact_service.dart';
import 'package:wayat/services/contact/contact_service_impl.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactController with _$ContactController;

abstract class _ContactController with Store {
  final ContactService _service = ContactServiceImpl();

  @observable
  ObservableList<Contact> _contacts = ObservableList.of(List.empty());

  @computed
  List<Contact> get availableContacts =>
      _contacts.where((contact) => contact.available).toList();

  @computed
  List<Contact> get unavailableContacts =>
      _contacts.where((contact) => !contact.available).toList();

  @action
  void updateContacts() {
    _contacts = ObservableList.of(_service.getAll());
  }
}
