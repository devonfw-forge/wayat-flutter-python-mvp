import 'package:azlistview/azlistview.dart';
import 'package:wayat/domain/contact/contact.dart';

class AZContactItem extends ISuspensionBean {
  final Contact contact;
  final String tag;

  AZContactItem({required this.contact, required this.tag});

  @override
  String getSuspensionTag() => tag;
}
