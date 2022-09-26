// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/services/contact/import_phones_service_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_contacts/flutter_contacts.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/services/contact/flutter_contacts_handler.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [FlutterContactsHandler].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlutterContactsHandler extends _i1.Mock
    implements _i2.FlutterContactsHandler {
  @override
  _i3.Future<bool> requestPermission() =>
      (super.noSuchMethod(Invocation.method(#requestPermission, []),
              returnValue: _i3.Future<bool>.value(false),
              returnValueForMissingStub: _i3.Future<bool>.value(false))
          as _i3.Future<bool>);
  @override
  _i3.Future<List<_i4.Contact>> getContacts() =>
      (super.noSuchMethod(Invocation.method(#getContacts, []),
              returnValue: _i3.Future<List<_i4.Contact>>.value(<_i4.Contact>[]),
              returnValueForMissingStub:
                  _i3.Future<List<_i4.Contact>>.value(<_i4.Contact>[]))
          as _i3.Future<List<_i4.Contact>>);
}