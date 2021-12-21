// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'main.dart';

class Env{ 
  static Env? value;
  String? _graphqlBaseURL;

  Env() {
    value= this;
    runApp(MyApp(this));
  }

  String get graphqlBaseURL => _graphqlBaseURL!;
}
