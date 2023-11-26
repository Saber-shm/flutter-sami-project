import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/com/details/details_page.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:frontend/pages/login/tech/tech_details.dart';
import 'package:http/http.dart' as http;

class TechHomePage extends StatefulWidget {
  const TechHomePage({super.key});

  @override
  State<TechHomePage> createState() => _TechHomePageState();
}

class _TechHomePageState extends State<TechHomePage> {
  late List<dynamic> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  retrieveNotes() async {
    var response =
        await http.get(Uri.parse('https://sirinelec.be/api/GetOrders/'));
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
        centerTitle: true,
        title: Text("Ordres"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      floatingActionButton:
          //     SpeedDial(icon: Icons.star, backgroundColor: Colors.blue, children: [
          //   SpeedDialChild(
          //     child:
          //         const Icon(Icons.arrow_circle_down_rounded, color: Colors.white),
          //     label: 'Download',
          //     backgroundColor: Colors.blueAccent,
          //     onTap: () {},
          //   ),
          //   SpeedDialChild(
          //     child: const Icon(Icons.email, color: Colors.white),
          //     label: 'Email',
          //     backgroundColor: Colors.blueAccent,
          //     onTap: () {},
          //   ),
          //   SpeedDialChild(
          //     child: const Icon(Icons.chat, color: Colors.white),
          //     label: 'Message',
          //     backgroundColor: Colors.blueAccent,
          //     onTap: () {},
          //   ),
          // ]),

          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: Icon(Icons.logout),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginDemo()));
          },
          heroTag: null,
          backgroundColor: Colors.green,
        )
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => COM_ajouter_ordre()));
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: FutureBuilder(
        future: retrieveNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RefreshIndicator(
              child: ListView.separated(
                itemCount: dataList.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                ),
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text("${dataList[index]['nom']}",
                        style: TextStyle(color: Colors.green)),
                    subtitle: Text(
                        "Poster en ${dataList[index]['post_date'].toString()}"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Tech_details_page(id: dataList[index]["id"])))
                    },
                  );
                },
              ),
              onRefresh: () => retrieveNotes());
          // return ListView.builder(
          //   itemCount: dataList.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(
          //       title: Text(dataList[index]["body"].toString()),
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
