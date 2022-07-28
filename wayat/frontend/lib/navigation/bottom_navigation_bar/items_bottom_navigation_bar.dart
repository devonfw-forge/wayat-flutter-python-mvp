import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wayat/lang/lang_singleton.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final AppLocalizations appLocalizations = GetIt.I.get<LangSingleton>().get();

List<BottomNavigationBarItem> bottomNavigationBarItems = [
  BottomNavigationBarItem(
    icon: const Icon(Icons.map),
    label: appLocalizations.appTitle,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.event_note_outlined),
    label: appLocalizations.events,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.contacts_outlined),
    label: appLocalizations.contacts,
  ),
  BottomNavigationBarItem(
    icon: const Icon(Icons.person_outline),
    label: appLocalizations.profile,
  ),
];
