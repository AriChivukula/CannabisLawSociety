import 'dart:io';
import 'package:flutter_web/material.dart';

Future<void> readStatute() async {
  var statute = await http.readBytes("/assets/statute.csv");
  print(statute);
}

void main() {
  readStatute();
  runApp(new Text('Hello World', textDirection: TextDirection.ltr));
}
