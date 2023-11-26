import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/check_in_page.dart';
import 'package:frontend/main.dart';
import 'package:frontend/pages/login/admin/acc_type_verify.dart';
import 'package:frontend/pages/login/admin/account_info.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_commercial.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_ordre.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_tech.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_utilisateur.dart';
import 'package:frontend/pages/login/admin/details.dart';
import 'package:frontend/pages/login/admin/ordre_suprimmer.dart';
import 'package:frontend/pages/login/admin/search_result.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Admin_Home_page extends StatefulWidget {
  const Admin_Home_page({super.key});

  @override
  State<Admin_Home_page> createState() => Admin__Home_pageState();
}

class Admin__Home_pageState extends State<Admin_Home_page> {
  late List<dynamic> dataList = [];
  bool isSearching = false;
  String searchText = "";
  final search_text = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<String>> fetchSearchSuggestions(String pattern) async {
    // Make an API request to get search suggestions based on the pattern
    // Parse the response and return a list of suggestions
    final response = await http.get(Uri.parse('Your_Suggestion_API_URL'));
    if (response.statusCode == 200) {
      final List<dynamic> suggestions = json.decode(response.body);
      return suggestions.map((suggestion) => suggestion.toString()).toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
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
        backgroundColor: Colors.green,
      ),
      drawer: const NavigationDrawer(),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.search),
      //   onPressed: () {
      //     {
      //       // ElevatedButton(

      //       final result = showDialog(
      //         context: context,
      //         builder: (_) => AlertDialog(
      //           title: Text("Rechercher"),
      //           actions: <Widget>[
      //             TextField(),
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => SearchResult(
      //                               search_text: search_text.text)));
      //                 },
      //                 child: Icon(Icons.search))
      //           ],
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: FutureBuilder(
        future: retrieveNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.separated(
            itemCount: dataList.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
            ),
            itemBuilder: (_, index) {
              // Filter the list based on searchText
              if (searchText.isEmpty ||
                  dataList[index]['nom']
                      .toLowerCase()
                      .contains(searchText.toLowerCase())) {
                return
                    // The rest of your code for Dismissible goes here
                    Column(
                  children: [
                    ListTile(
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
                    )
                  ],
                );
              } else {
                // Return an empty container to hide the item
                return Container();
              }
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
        },
      ),
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
        padding: const EdgeInsets.only(top: 60),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Les ordres nom suprimmer"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Admin_Home_page()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_rounded),
              title: const Text("Les ordres suprimmer"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Admin_Ordre_Suprimmer()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text("Informations des comptes"),
              onTap: () {
                final result = showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Choisir type de compte'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccInfo(type: 'commercial')));
                                  // Code to handle the first button click
                                },
                                child: Text('Commercial'),
                              ),
                              SizedBox(
                                  height: 10), // Add spacing between buttons
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccInfo(type: 'tech')));
                                  // Code to handle the first button click
                                },
                                child: Text('Technicien'),
                              ),
                            ],
                          ),
                        ));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter une ordre"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AjouterOrdre()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter un Commercial"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Admin_ajouter_utilisateur(type: "C")));
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Ajouter un Technicien"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Admin_ajouter_utilisateur(type: "T")));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Se deconnecter"),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                WidgetsFlutterBinding.ensureInitialized();
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final token = prefs.getString('refresh');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp(token: token)));
              },
            )
          ],
        ),
      );
}
