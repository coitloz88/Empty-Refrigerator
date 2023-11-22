import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

void sendPhoto() async {}
void fetchBboxWithIngredients(BuildContext context) async {}
void fetchRecipes(BuildContext context) async {}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}
