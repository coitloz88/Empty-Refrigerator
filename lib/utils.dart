import 'dart:convert';
import 'dart:math';
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

List<String> chooseRandomTenItems(List<dynamic> list) {
  var rng = new Random();
  List<String> result = [];
  List<String> copyList = List<String>.from(list);
  int count = (copyList.length >= 10) ? 10 : copyList.length;

  for (var i = 0; i < count; i++) {
    var randomIndex = rng.nextInt(copyList.length);
    result.add(copyList[randomIndex]);
    copyList.removeAt(randomIndex);
  }

  return result;
}
