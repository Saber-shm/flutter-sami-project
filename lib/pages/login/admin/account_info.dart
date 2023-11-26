import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccInfo extends StatefulWidget {
  final type;
  const AccInfo({super.key, this.type});

  @override
  State<AccInfo> createState() => _AccInfoState();
}

class _AccInfoState extends State<AccInfo> {
  late var account_info;

  @override
  void initState() {
    super.initState();
  }

  getinfo() async {
    if (widget.type == "tech") {
      var response =
          await http.get(Uri.parse('https://sirinelec.be/api/GetAccInfoTech/'));
      account_info = json.decode(response.body);
      print(account_info);
    }
    if (widget.type == "commercial") {
      var response =
          await http.get(Uri.parse('https://sirinelec.be/api/GetAccInfoCom/'));
      account_info = json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text("Information des comptes")),
        body: FutureBuilder(
            future: getinfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is loading, you can display a loading indicator.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurs, you can display an error message.
                return Text('Error: ${snapshot.error}');
              } else {
                // Data has been successfully loaded, you can display it here.
                return AccountListView(account_info);
              }
            }));
  }
}

class AccountListView extends StatelessWidget {
  final List<dynamic> accountList;

  AccountListView(this.accountList);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accountList.length,
      itemBuilder: (context, index) {
        final account = accountList[index];
        return Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('ID: ${account['id']}'),
                Text('Prenom: ${account['nom']}'),
                Text('Nom: ${account['prenom']}'),
                Text('Ntel: ${account['phone_number']}'),
                Text('Email: ${account['email']}'),
                Text('Mot de passe: ${account['password']}'),
                Text('User ID: ${account['user']}'),
                // Add additional fields as needed
              ],
            ),
          ),
        );
      },
    );
  }
}
