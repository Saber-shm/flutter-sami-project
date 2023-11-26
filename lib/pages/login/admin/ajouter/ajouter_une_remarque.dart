import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjouterRemarque extends StatefulWidget {
  final ordre_id;
  AjouterRemarque({super.key, this.ordre_id});

  @override
  State<AjouterRemarque> createState() => _AjouterRemarqueState();
}

class _AjouterRemarqueState extends State<AjouterRemarque> {
  final remarque = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharePref();
  }

  void initSharePref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void ajouter_remarque() async {
    if (remarque.text.isNotEmpty) {
      final token = prefs.getString('refresh');
      Map<String, dynamic> jwtdecoder = JwtDecoder.decode(token!);
      var regbody = {
        "text": remarque.text,
        "ordre": widget.ordre_id,
        "posted_by": jwtdecoder["user_id"].toString()
      };
      var response = await http.post(
          Uri.parse("https://sirinelec.be//api/PostRemarque/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var jsonResponse = jsonDecode(response.body);
      Navigator.pop(context);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter une remarque:"),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              child: TextField(
                controller: remarque,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Ajouter Remarque',
                  // hintStyle: TextStyle(color: Colors), // Hint text color
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green), // Focused border color
                  ),
                ),
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
                      ajouter_remarque();
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
        ));
  }
}
