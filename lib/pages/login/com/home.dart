import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_ordre.dart';
import 'package:frontend/pages/login/com/ajouter/ajouter_ordre_com.dart';
import 'package:frontend/pages/login/com/details/details_page.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Com_home_page extends StatefulWidget {
  const Com_home_page({super.key});

  @override
  State<Com_home_page> createState() => _Com_home_pageState();
}

class _Com_home_pageState extends State<Com_home_page> {
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
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AjouterOrdre()));
          },
          heroTag: null,
          backgroundColor: Colors.green,
        ),
        SizedBox(
          height: 10,
        ),
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
                                  COM_details_page(id: dataList[index]["id"])))
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
