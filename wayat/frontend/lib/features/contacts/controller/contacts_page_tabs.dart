enum ContactsPageTabs {
  friends(0),
  requests(1),
  suggestions(2);

  const ContactsPageTabs(this.value);
  final int value;

  factory ContactsPageTabs.fromIndex(int value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => ContactsPageTabs.friends);
  }
}
