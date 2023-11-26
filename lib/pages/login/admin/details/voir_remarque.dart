import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Admin_Remarque extends StatefulWidget {
  final ordre_id;
  Admin_Remarque({super.key, this.ordre_id});

  @override
  State<Admin_Remarque> createState() => Admin_RemarqueState();
}

class Admin_RemarqueState extends State<Admin_Remarque> {
  late List<dynamic> dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  retrieveRemarques() async {
    var response = await http.get(Uri.parse(
        'https://sirinelec.be//api/GetOrderRemarques/${widget.ordre_id}'));

    if (response.statusCode == 200) {
      dataList = json.decode(response.body); // Parse JSON here
      print(dataList);
      print('bravo');
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voir les remarques:"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: retrieveRemarques(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ListView.separated(
              itemCount: dataList.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
              ),
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text("${dataList[index]['text']}",
                      style: TextStyle(color: Colors.green)),
                  subtitle: Text(
                      "Posté par  ${dataList[index]['posted_by_username'].toString()} en ${dataList[index]["post_date"]}"),
                );
              },
            );
          }),
    );
  }
}
