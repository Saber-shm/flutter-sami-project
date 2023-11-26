import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/home.dart';
import 'package:http/http.dart' as http;

class Add_commercial extends StatefulWidget {
  final user_id;
  Add_commercial({super.key, this.user_id});

  @override
  State<Add_commercial> createState() => _Add_commercialState();
}

class _Add_commercialState extends State<Add_commercial> {
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final numtel = TextEditingController();
  final email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void ajouter_remarque() async {
    if (nom.text.isNotEmpty &&
        prenom.text.isNotEmpty &&
        email.text.isNotEmpty) {
      var regbody = {
        "nom": nom.text,
        "prenom": prenom.text,
        "email": email.text,
        "phone_number": numtel.text
      };
      var response = await http.post(
          Uri.parse("https://sirinelec.be//api/PostCom/${widget.user_id}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var jsonResponse = jsonDecode(response.body);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Admin_Home_page()));
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter Commercial Etape 2:"),
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
                controller: nom,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), // Focused border color
                    ),
                    labelStyle: TextStyle(color: Colors.green),
                    labelText: 'Nom:',
                    hintText: 'Nom:'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              //  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: prenom,
                style: TextStyle(color: Colors.green), // Text color

                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), // Focused border color
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.green),
                    labelText: 'Prenom',
                    hintText: 'Prenom'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              //  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: email,
                style: TextStyle(color: Colors.green), // Text color

                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), // Focused border color
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.green),
                    hintText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              //  EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: numtel,
                style: TextStyle(color: Colors.green), // Text color

                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green), // Focused border color
                    ),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.green),
                    labelText: 'Numtel',
                    hintText: 'Numtel'),
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
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Background color
                      ),
                      onPressed: () {
                        ajouter_remarque();
                      },
                      child: Text(
                        'Envoyer',
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ))),
          ],
        )));
  }
}
