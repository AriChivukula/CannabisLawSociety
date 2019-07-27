import 'package:flutter_web/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;

Future<List<List<String>>> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  print(statute.body); // TODO: remove
  return csv.CsvToListConverter(shouldParseNumbers: false).convert(statute.body);
}

Future<void> renderStatute() async {
  var statuteList = await readStatute();
  print(statuteList); // TODO: remove
  runApp(Table(
    children: [
      for (var statuteListRow in statuteList)
        TableRow(
          children: [
            for (var statuteListCell in statuteListRow)
              TableCell(
                child: new Text(statuteListCell),
              ),
          ],
        ),
    ],
  ));
}

void main() {
  renderStatute();
}
