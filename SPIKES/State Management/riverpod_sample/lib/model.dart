class Database {
  int fakeDatabase;

  Database({this.fakeDatabase = -1});

  Future<void> initDatabase() async {
    fakeDatabase = 0;
  }

  Future<String> getUserData() {
    return Future.delayed(const Duration(seconds: 3), () {
      return "username example";
    });
  }

  Future<int> increment() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return fakeDatabase = fakeDatabase + 1;
    });
  }

  Future<int> decrement() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return fakeDatabase = fakeDatabase - 1;
    });
  }
}
