import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:grocery_app/utils.dart';

class BboxState with ChangeNotifier {
  late Uint8List _bytes;
  Uint8List get bytes => _bytes;

  void setBytes(String base64String) {
    _bytes = dataFromBase64String(base64String);
    notifyListeners();
  }
}
