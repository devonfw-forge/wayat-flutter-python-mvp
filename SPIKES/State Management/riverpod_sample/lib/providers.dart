import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/model.dart';

final counterProvider = StateProvider((ref) => 0);

final firstStringProvider = Provider((ref) => "First String");
final secondStringProvider = Provider((ref) => "Second String");
final databaseProvider = Provider<Database>((ref) => Database());

final userProvider = FutureProvider<String>((ref) async {
  return ref.read(databaseProvider).getUserData();
});
