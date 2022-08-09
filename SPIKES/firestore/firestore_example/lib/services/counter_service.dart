// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

class CounterService {
  String baseUrl = "http://10.0.2.2";

  Future<void> increaseCounter(int quantity) async {
    Increment increment = Increment(quantity);
    final body = json.encode(increment.toMap());
    print(body);
    Response res = await http.post(Uri.parse("$baseUrl/counter/increment"),
        body: body, headers: {"Content-Type": ContentType.json.toString()});
    print(res.statusCode);
  }
}

class Increment {
  int increment;

  Increment(this.increment);

  Map<String, dynamic> toMap() {
    return {"increment": increment};
  }
}
