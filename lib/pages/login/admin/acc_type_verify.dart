import 'package:flutter/material.dart';
import 'package:frontend/pages/login/admin/account_info.dart';

class VerifyAccType extends StatefulWidget {
  const VerifyAccType({super.key});

  @override
  State<VerifyAccType> createState() => _VerifyAccTypeState();
}

class _VerifyAccTypeState extends State<VerifyAccType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Type de compte:"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    left: 100.0, right: 101.0, top: 150, bottom: 0),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccInfo(
                                    type: "commercial",
                                  )));
                      // ajouter_sav();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                    ),
                    child: Text(
                      'Commercial',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(
                    left: 100.0, right: 101.0, top: 150, bottom: 0),
                child: Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      // ajouter_sav();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccInfo(type: "tech")));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Background color
                    ),
                    child: Text(
                      'Tech',
                      style: TextStyle(color: Colors.white, fontSize: 23),
                    ),
                  ),
                )),
          ],
        ));
  }
}
