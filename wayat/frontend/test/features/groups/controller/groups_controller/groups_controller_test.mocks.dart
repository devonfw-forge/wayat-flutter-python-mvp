// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/features/groups/controller/groups_controller/groups_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:image_picker/image_picker.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/domain/group/group.dart' as _i4;
import 'package:wayat/services/groups/groups_service.dart' as _i2;

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

/// A class which mocks [GroupsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGroupsService extends _i1.Mock implements _i2.GroupsService {
  MockGroupsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Group>> getAll() =>
      (super.noSuchMethod(Invocation.method(#getAll, []),
              returnValue: _i3.Future<List<_i4.Group>>.value(<_i4.Group>[]))
          as _i3.Future<List<_i4.Group>>);
  @override
  _i3.Future<dynamic> create(_i4.Group? group, _i5.XFile? picture) =>
      (super.noSuchMethod(Invocation.method(#create, [group, picture]),
          returnValue: _i3.Future<dynamic>.value()) as _i3.Future<dynamic>);
}