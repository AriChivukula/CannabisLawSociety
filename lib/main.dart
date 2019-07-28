import 'package:flutter_web/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;

void main() => runApp(
  new MaterialApp(
    home: new CannabisLawSociety(),
  )
);

Future<List<String>> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  var statuteCSV = csv.CsvToListConverter(shouldParseNumbers: false).convert(statute.body);
  return statuteCSV.map(
    (statuteRow) => statuteRow.map(
      (statuteCell) => statuteCell == null ? "" : statuteCell is String ? statuteCell : "",
    ).join(" <> "),
  );
}

class CannabisLawSociety extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CannabisLawSocietyState();
}

class CannabisLawSocietyState extends State<CannabisLawSociety> {
  List<String> items;
  TextEditingController controller = new TextEditingController();
  String filter;

  @override
  void initState() {
    readStatute().then((result) {
      setState(() {
        items = result;
      });
    });
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new TextField(
            decoration: new InputDecoration(
              labelText: "Search Statute"
            ),
            controller: controller,
          ),
          new Expanded(
            child: new ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                if (filter == null || filter == "") {
                  return new Card(child: new Text(items[index]));
                } else if (items[index].toLowerCase().contains(filter.toLowerCase())) {
                  return new Card(child: new Text(items[index]));
                } else {
                  return new Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
