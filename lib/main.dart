import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;

Future<void> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  print(statute);
}

void main() {
  readStatute();
  runApp(new Text('Hello World', textDirection: TextDirection.ltr));
}
