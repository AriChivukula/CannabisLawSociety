import 'package:flutter_web/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;

Future<List<List<dynamic>>> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  return csv.CsvToListConverter(shouldParseNumbers: false).convert(statute.body);
}

Future<Widget> renderStatute() async {
  var statuteList = await readStatute();
  return Table(
    children: [
      for (var statuteListRow in statuteList)
        TableRow(
          children: [
            for (var statuteListCell in statuteListRow)
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(statuteListCell is String ? statuteListCell : ""),
                ),
              ),
          ],
        ),
    ],
  );
}

Future<Widget> renderSearch() async {
  return TextField(
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.search),
      hintText: "Search...",
    ),
  );
}

Future<void> render() async {
  var searchUI = await renderSearch();
  var statuteUI = await renderStatute();
  runApp(Column(
    children: <Widget>[
      searchUI,
      statuteUI,
    ],
  ));
}

void main() => renderStatute();
