import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class JsonPlotto {
  JsonPlotto._private();
  static JsonPlotto _instance;
  factory JsonPlotto.getInstance() {
    _instance ??= JsonPlotto._private();
    return _instance;
  }

  Future<dynamic> fetchJson() async {
    String data = await rootBundle.loadString("assets/plotto.json");
    return jsonDecode(data);
  }
}
