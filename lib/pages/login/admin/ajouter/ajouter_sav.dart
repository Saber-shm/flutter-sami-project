import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AjouterSav extends StatefulWidget {
  final id;
  AjouterSav({super.key, this.id});

  @override
  State<AjouterSav> createState() => AjouterSavState();
}

class AjouterSavState extends State<AjouterSav> {
  final nom_et_prenom_client = TextEditingController();
  final date_de_linstallation = TextEditingController();
  final equipe_qui_install_toiture = TextEditingController();
  final raccordement_electritiens = TextEditingController();
  final nom_sous_traitant = TextEditingController();
  final description_de_panne = TextEditingController();
  final heur_arrive = TextEditingController();
  final heur_depart = TextEditingController();
  final temps_intervention = TextEditingController();
  final materiel_utiliser = TextEditingController();
  final remarque = TextEditingController();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  // final String formattedDate = dateFormatter.format(selectedDate);

  DateTime? selectedDate;
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

  // Declare selectedDate as nullable

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        print(picked);
        selectedDate = picked;
      });
    }
  }

  ajouter_sav() async {
    if (remarque.text.isNotEmpty) {
      final token = prefs.getString('refresh');
      Map<String, dynamic> jwtdecoder = JwtDecoder.decode(token!);
      var regbody = {
        "posted_by": jwtdecoder["user_id"].toString(),
        "Nom_et_prenom_du_client": nom_et_prenom_client.text,
        "date_de_l_installation": dateFormatter.format(selectedDate!),
        "equipe_qui_installe_toiture": equipe_qui_install_toiture.text,
        'Raccordement_electiricien': raccordement_electritiens.text,
        "nom_sou_traitant": nom_sous_traitant.text,
        "description_de_la_panne": description_de_panne.text,
        "heure_darrive": heur_arrive.text,
        "heure_de_depart": heur_depart.text,
        "temps_intervention": temps_intervention.text,
        "materiel_utilise": materiel_utiliser.text,
        "remarque": remarque.text,
      };
      print(jsonEncode(regbody));

      var response = await http.post(
          Uri.parse("https://sirinelec.be//api/AjouterSAV/${widget.id}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      print(response.body);

      var jsonResponse = jsonDecode(response.body);
      Navigator.pop(context);
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ajouter SAV:"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              child: TextField(
                controller: nom_et_prenom_client,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: ' Nom et prenom du client: ',
                  // hintStyle: TextStyle(color: Colors), // Hint text color
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green), // Focused border color
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  // Define the action to be taken when the button is clicked
                  _selectDate(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 50, bottom: 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    height: 48.0,
                    decoration: BoxDecoration(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Date de visite: ',
                            style: TextStyle(),
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.green),
                      ],
                    ),
                  ),
                )),
            // Padding(
            //     padding: const EdgeInsets.only(
            //         left: 15.0, right: 15.0, top: 50, bottom: 0),
            //     child: ElevatedButton(
            //         onPressed: () {
            //           _selectDate(context);
            //         },
            //         // style: ButtonStyle(shadowColor: Colors.green),
            //         child: Text("Date de l'installations", style: TextStyle()))
            // TextField(
            //   controller: date_de_linstallation,
            //   style: TextStyle(color: Colors.green), // Text color
            //   decoration: InputDecoration(
            //     hintText: 'Date de l installation : ',
            //     // hintStyle: TextStyle(color: Colors), // Hint text color
            //     focusedBorder: OutlineInputBorder(
            //       borderSide:
            //           BorderSide(color: Colors.green), // Focused border color
            //     ),
            //   ),
            // ),
            // ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 50, bottom: 0),
              child: TextField(
                controller: equipe_qui_install_toiture,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: ' Equipe qui install toiture: ',
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
              child: TextField(
                controller: raccordement_electritiens,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Raccordement electritiens: ',
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
              child: TextField(
                controller: description_de_panne,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Description de panne: ',
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
              child: TextField(
                controller: heur_arrive,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Heur d arrive: ',
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
              child: TextField(
                controller: heur_depart,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Heur depart: ',
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
              child: TextField(
                controller: temps_intervention,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Temps intervention: ',
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
              child: TextField(
                controller: materiel_utiliser,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Materiel utiliser: ',
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
              child: TextField(
                controller: remarque,
                style: TextStyle(color: Colors.green), // Text color
                decoration: InputDecoration(
                  hintText: 'Remarque: ',
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
                      ajouter_sav();
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
