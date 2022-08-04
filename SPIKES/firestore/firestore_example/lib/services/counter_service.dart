// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:http/http.dart' as http;

class CounterService {
  String baseUrl = "http://localhost:8080";

  void increaseCounter(int quantity) {
    http.post(Uri.parse("$baseUrl/counter/increment"),
        body: Increment(quantity).toMap());
  }
}

class Increment {
  int increment;

  Increment(this.increment);

  Map<String, dynamic> toMap() {
    return {"increment": increment};
  }
}
