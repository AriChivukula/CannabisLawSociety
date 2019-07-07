import 'package:flutter_web/material.dart';

void main() {
  var statute = await http.readBytes("/assets/statute.csv");
  print(statute);
  runApp(new Text('Hello World', textDirection: TextDirection.ltr));
}
