import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_commercial.dart';
import 'package:frontend/pages/login/admin/ajouter/ajouter_tech.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Admin_ajouter_utilisateur extends StatefulWidget {
  final type;
  const Admin_ajouter_utilisateur({super.key, this.type});

  @override
  State<Admin_ajouter_utilisateur> createState() =>
      _Admin_ajouter_utilisateurState();
}

class _Admin_ajouter_utilisateurState extends State<Admin_ajouter_utilisateur> {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void ajouter_utilisateur() async {
    if (username.text.isNotEmpty) {
      var regbody = {"username": username.text, "password": password.text};
      var response = await http.post(
          Uri.parse("https://sirinelec.be//api/PostUser/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (widget.type == "C") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Add_commercial(user_id: jsonResponse["id"])));
      } else if (widget.type == "T") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Add_Tech(user_id: jsonResponse["id"])));
      }
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter un utilisateur:"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              //  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), // Focused border color
                    ),
                    labelStyle: TextStyle(color: Colors.green),
                    labelText: 'Username',
                    hintText: 'Username'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),

              //  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), // Focused border color
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.green),
                    hintText: 'Password'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 50, bottom: 0),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      ajouter_utilisateur();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                    ),
                    child: Text(
                      'Envoyer',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                )),
          ],
        )));
  }
}
