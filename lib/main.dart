import 'package:flutter_web/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;

Future<List<List<dynamic>>> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  return csv.CsvToListConverter(shouldParseNumbers: false).convert(statute.body);
}

Future<void> renderStatute() async {
  var statuteList = await readStatute();
  runApp(Padding(
    padding: const EdgeInsets.all(5.0),
    child: Table(
      border: TableBorder.all(width: 1.0, color: Colors.black),
      children: [
        for (var statuteListRow in statuteList)
          TableRow(
            children: [
              for (var statuteListCell in statuteListRow)
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: new Text(statuteListCell as String),
                  ),
                ),
            ],
          ),
      ],
    ),
  ));
}

void main() {
  renderStatute();
}
