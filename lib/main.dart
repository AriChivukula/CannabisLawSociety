import 'package:flutter_web/material.dart';
import 'package:csv/csv.dart' as csv;
import 'package:http/http.dart' as http;

void main() => runApp(
  MaterialApp(
    home: CannabisLawSociety(),
  )
);

Future<List<List<String>>> readStatute() async {
  var statute = await http.get("/assets/statute.csv");
  var statuteCSV = csv.CsvToListConverter(shouldParseNumbers: false).convert(statute.body);
  return statuteCSV.map(
    (statuteRow) => statuteRow.map(
      (statuteCell) => statuteCell as String,
    ).toList(),
  ).toList();
}

class CannabisLawSociety extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CannabisLawSocietyState();
}

class CannabisLawSocietyState extends State<CannabisLawSociety> {
  List<String> headers = [];
  List<List<String>> items = [];
  List<List<String>> filteredItems = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    readStatute().then((result) {
      setState(() {
        if (result.length > 0) {
          headers = result.removeAt(0);
          items = result;
          filteredItems = items;
        }
      });
    });
    controller.addListener(() {
      setState(() {
        if (controller.text == "") {
          filteredItems = items;
        } else {
          filteredItems = items.where(
            (item) => item.join(" ").toLowerCase().contains(controller.text.toLowerCase()),
          ).toList();
        }
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
    return Material(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Search Statute"
            ),
            controller: controller,
          ),
          getCard(headers),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) => getCard(filteredItems[index]),
            ),
          ),
        ],
      ),
    );
  }

  Card getCard(List<String> item) {
    return Card(
      child: Row(
        children: item.map(
          (itemPart) => Expanded(
            child: Text(itemPart),
          ),
        ).toList(),
      ),
    );
  }
}
