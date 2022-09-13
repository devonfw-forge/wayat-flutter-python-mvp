// Mocks generated by Mockito 5.3.0 from annotations
// in wayat/test/services/group/group_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wayat/services/common/http_provider/http_provider.dart' as _i3;

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

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeStreamedResponse_1 extends _i1.SmartFake
    implements _i2.StreamedResponse {
  _FakeStreamedResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeByteStream_2 extends _i1.SmartFake implements _i2.ByteStream {
  _FakeByteStream_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [HttpProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpProvider extends _i1.Mock implements _i3.HttpProvider {
  MockHttpProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl =>
      (super.noSuchMethod(Invocation.getter(#baseUrl), returnValue: '')
          as String);
  @override
  set baseUrl(String? _baseUrl) =>
      super.noSuchMethod(Invocation.setter(#baseUrl, _baseUrl),
          returnValueForMissingStub: null);
  @override
  _i4.Future<Map<String, dynamic>> sendGetRequest(String? subPath) =>
      (super.noSuchMethod(Invocation.method(#sendGetRequest, [subPath]),
              returnValue:
                  _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}))
          as _i4.Future<Map<String, dynamic>>);
  @override
  _i4.Future<_i2.Response> sendPostRequest(
          String? subPath, Map<String, dynamic>? body) =>
      (super.noSuchMethod(Invocation.method(#sendPostRequest, [subPath, body]),
              returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
                  this, Invocation.method(#sendPostRequest, [subPath, body]))))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<_i2.StreamedResponse> sendPostImageRequest(
          String? subPath, String? filePath, String? type) =>
      (super.noSuchMethod(
          Invocation.method(#sendPostImageRequest, [subPath, filePath, type]),
          returnValue: _i4.Future<_i2.StreamedResponse>.value(
              _FakeStreamedResponse_1(
                  this,
                  Invocation.method(
                      #sendPostImageRequest, [subPath, filePath, type])))) as _i4
          .Future<_i2.StreamedResponse>);
  @override
  _i4.Future<bool> sendPutRequest(
          String? subPath, Map<String, dynamic>? body) =>
      (super.noSuchMethod(Invocation.method(#sendPutRequest, [subPath, body]),
          returnValue: _i4.Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<bool> sendDelRequest(String? subPath) =>
      (super.noSuchMethod(Invocation.method(#sendDelRequest, [subPath]),
          returnValue: _i4.Future<bool>.value(false)) as _i4.Future<bool>);
}

/// A class which mocks [Response].
///
/// See the documentation for Mockito's code generation for more information.
class MockResponse extends _i1.Mock implements _i2.Response {
  MockResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Uint8List get bodyBytes =>
      (super.noSuchMethod(Invocation.getter(#bodyBytes),
          returnValue: _i5.Uint8List(0)) as _i5.Uint8List);
  @override
  String get body =>
      (super.noSuchMethod(Invocation.getter(#body), returnValue: '') as String);
  @override
  int get statusCode =>
      (super.noSuchMethod(Invocation.getter(#statusCode), returnValue: 0)
          as int);
  @override
  Map<String, String> get headers =>
      (super.noSuchMethod(Invocation.getter(#headers),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  bool get isRedirect =>
      (super.noSuchMethod(Invocation.getter(#isRedirect), returnValue: false)
          as bool);
  @override
  bool get persistentConnection =>
      (super.noSuchMethod(Invocation.getter(#persistentConnection),
          returnValue: false) as bool);
}

/// A class which mocks [StreamedResponse].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamedResponse extends _i1.Mock implements _i2.StreamedResponse {
  MockStreamedResponse() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ByteStream get stream => (super.noSuchMethod(Invocation.getter(#stream),
          returnValue: _FakeByteStream_2(this, Invocation.getter(#stream)))
      as _i2.ByteStream);
  @override
  int get statusCode =>
      (super.noSuchMethod(Invocation.getter(#statusCode), returnValue: 0)
          as int);
  @override
  Map<String, String> get headers =>
      (super.noSuchMethod(Invocation.getter(#headers),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  bool get isRedirect =>
      (super.noSuchMethod(Invocation.getter(#isRedirect), returnValue: false)
          as bool);
  @override
  bool get persistentConnection =>
      (super.noSuchMethod(Invocation.getter(#persistentConnection),
          returnValue: false) as bool);
}