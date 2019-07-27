import 'package:flutter_web/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;

Future<List<List<string>>> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  print(statute.body);
  return csv.CsvToListConverter(shouldParseNumbers: false).convert(statute.body);
}

Future<void> renderStatute() async {
  var statuteList = await readStatute();
  print(statuteList);
  runApp(new Text('Hello World', textDirection: TextDirection.ltr));
}

void main() {
  render();
}
