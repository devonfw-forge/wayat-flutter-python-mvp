// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestions_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SuggestionsController on _SuggestionsController, Store {
  late final _$suggestedContactsAtom =
      Atom(name: '_SuggestionsController.suggestedContacts', context: context);

  @override
  List<Contact> get suggestedContacts {
    _$suggestedContactsAtom.reportRead();
    return super.suggestedContacts;
  }

  @override
  set suggestedContacts(List<Contact> value) {
    _$suggestedContactsAtom.reportWrite(value, super.suggestedContacts, () {
      super.suggestedContacts = value;
    });
  }

  late final _$updateSuggestedContactsAsyncAction = AsyncAction(
      '_SuggestionsController.updateSuggestedContacts',
      context: context);

  @override
  Future<dynamic> updateSuggestedContacts() {
    return _$updateSuggestedContactsAsyncAction
        .run(() => super.updateSuggestedContacts());
  }

  late final _$_SuggestionsControllerActionController =
      ActionController(name: '_SuggestionsController', context: context);

  @override
  void sendRequest(Contact contact) {
    final _$actionInfo = _$_SuggestionsControllerActionController.startAction(
        name: '_SuggestionsController.sendRequest');
    try {
      return super.sendRequest(contact);
    } finally {
      _$_SuggestionsControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
suggestedContacts: ${suggestedContacts}
    ''';
  }
}
