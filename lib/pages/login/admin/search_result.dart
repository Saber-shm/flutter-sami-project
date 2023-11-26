import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'details.dart';

class SearchResult extends StatefulWidget {
  final search_text;
  const SearchResult({super.key, this.search_text});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  late List<dynamic> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // retrieveNotes();
  }

  retrieveNotes() async {
    var response = await http.post(
        Uri.parse('https://sirinelec.be/api/GetSearchResult/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": widget.search_text}));
    if (response.statusCode == 200) {
      dataList = json.decode(response.body); // Parse JSON here
      print(dataList);
      print('bravo');
      print(dataList);
      print('bravo');
      print(dataList);
      print('bravo');
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Votre recherche:")),
      body: FutureBuilder(
          future: retrieveNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is loading, you can display a loading indicator.
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurs, you can display an error message.
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.separated(
                itemCount: dataList.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                ),
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text("${dataList[index]['nom']}",
                        style: TextStyle(color: Colors.green)),
                    subtitle: Text(
                        "Last edited on ${dataList[index]['date'].toString()}"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Admin_Details(id: dataList[index]["id"])))
                    },
                  );
                },
              );
              // return ListView.builder(
              //   itemCount: dataList.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     return ListTile(
              //       title: Text(dataList[index]["body"].toString()),
              //     );
              //   },
              // );
            }
          }),
    );
  }
}
