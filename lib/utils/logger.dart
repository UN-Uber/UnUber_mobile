// Package imports:
import 'package:logger/logger.dart';

class CustomLogger{
  late Logger logger;

  CustomLogger._internal(){
    logger= Logger();
  }

  static final CustomLogger _singleton= CustomLogger._internal();
  factory CustomLogger() => _singleton;
}
