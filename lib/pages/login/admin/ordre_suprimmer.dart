import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/details.dart';
import 'package:http/http.dart' as http;

class Admin_Ordre_Suprimmer extends StatefulWidget {
  const Admin_Ordre_Suprimmer({super.key});

  @override
  State<Admin_Ordre_Suprimmer> createState() => Admin_Ordre_SuprimmerState();
}

class Admin_Ordre_SuprimmerState extends State<Admin_Ordre_Suprimmer> {
  late List<dynamic> dataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  retrieveNotes() async {
    print("2");

    var response = await http
        .get(Uri.parse('https://sirinelec.be//api/GetDeletedOrders/'));
    print("2");
    print(response);
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
        title: Text("Ordres suprimmer:"),
        backgroundColor: Colors.green,
      ),
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
                  return Dismissible(
                      key: ValueKey(dataList[index]["name"]),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (direction) {},
                      confirmDismiss: (direction) async {
                        final result = await showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Warning"),
                            content: Text(
                                "Are you sure you want to delete this ordre?"),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () {
                                    print("cant");
                                  },
                                  child: Text("Yes")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Text("No")),
                            ],
                          ),
                        );
                        print(result);
                        return result;
                      },
                      child: ListTile(
                        title: Text("${dataList[index]['nom']}",
                            style: TextStyle(color: Colors.green)),
                        subtitle: Text(
                            "Poster en ${dataList[index]['post_date'].toString()}"),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Admin_Details(id: dataList[index]["id"])))
                        },
                      ));
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildheader(context), builditems(context)],
        ),
      ));

  Widget buildheader(BuildContext context) => Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top));
  Widget builditems(BuildContext context) => Container(
        padding: const EdgeInsets.only(top: 100),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Les ordres nom suprimmer"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text("Les ordres suprimmer"),
              onTap: () {
                print("hello");
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text("Informations des comptes"),
              onTap: () {
                print("hello");
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter une ordre"),
              onTap: () {
                print("hello");
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter un Commercial"),
              onTap: () {
                print("hello");
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter un Technicien"),
              onTap: () {
                print("hello");
              },
            )
          ],
        ),
      );
}
