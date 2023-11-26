import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Modifier extends StatefulWidget {
  final id;
  const Modifier({super.key, this.id});

  @override
  State<Modifier> createState() => _ModifierState();
}

class _ModifierState extends State<Modifier> {
  final nom = TextEditingController();
  final prenom = TextEditingController();
  final adresse = TextEditingController();
  final date_de_visite = TextEditingController(text: "Hdllo");
  final email = TextEditingController();
  final ntel = TextEditingController();
  final cp = TextEditingController();
  final localite = TextEditingController();
  final ngsm = TextEditingController();
  final nom_de_societe = TextEditingController();
  final forme_juridique = TextEditingController();
  final date_de_signature = TextEditingController();
  final ean54145 = TextEditingController();
  final ncompteur = TextEditingController();
  final ntva = TextEditingController();
  final adress_de_facturation_adress = TextEditingController();
  final adress_de_facturation_cp = TextEditingController();
  final adress_de_facturation_localite = TextEditingController();
  final adress_de_livraison_adress = TextEditingController();
  final adress_de_livraison_localite = TextEditingController();
  final adress_de_livraison_cp = TextEditingController();
  final remarque = TextEditingController();
  final nomvre_ppv = TextEditingController();
  final type_pvv = TextEditingController();
  final type_de_range_ppv = TextEditingController();
  final nombre_pan_de_toiture = TextEditingController();
  final nombre_ppv_toiture_1 = TextEditingController();
  final toiture_1 = TextEditingController();
  final sous_toiture = TextEditingController();
  final type_de_corniche = TextEditingController();
  final tuile_rechange = TextEditingController();
  final orientation = TextEditingController();
  final nombre_ppv_toiture_2 = TextEditingController();
  final hauteur_sous_corniche = TextEditingController();
  final etat_du_toit = TextEditingController();
  final si_a_larriere_yatil_un_acces = TextEditingController();
  final si_7m_nacelle = TextEditingController();
  final si_non_decrire_la_situation = TextEditingController();
  final acces_libre_le_jour_du_chantier = TextEditingController();
  final les_panneaux_doivent_etre_installe = TextEditingController();
  final nombre_ppv_toiture_3 = TextEditingController();
  final type_de_compteur = TextEditingController();
  final onduleur_1 = TextEditingController();
  final onduleur_2 = TextEditingController();
  final onduleur_3 = TextEditingController();
  final Nombre_doptimiseur = TextEditingController();
  final Enphase = TextEditingController();
  final gaine_technique_present = TextEditingController();
  final Espace_pres_du_coffret_pour_londuleur_meme_piece =
      TextEditingController();
  final etat_de_linstalation = TextEditingController();
  final prise_de_terre_controle_5_derniere_annes = TextEditingController();
  final pressence_differentiel_general = TextEditingController();
  final coffret_20_cm_disponible = TextEditingController();
  final tranchee = TextEditingController();
  final nombre_de_metre_de_tranche = TextEditingController();
  final le_client_se_charge_de_gaine = TextEditingController();
  final nombre_de_metres_entre_onduleur_et_panneaux = TextEditingController();
  final le_client_souheite_il_le_monitoring = TextEditingController();
  final le_modem_est_il_dans_la_meme_piece_que_londuleur =
      TextEditingController();
  final nombres_de_metres_du_modem_a_lonuduleur = TextEditingController();
  final le_projet_sera_finance_par = TextEditingController();
  final condition_de_paiement = TextEditingController();
  final date_de_la_vt = TextEditingController();
  final vt_effectue_par = TextEditingController();
  final commentaire_technicien = TextEditingController();
  final statut_vt = TextEditingController();
  final coffret_general_conforme = TextEditingController();
  final ajout_coffret_supp = TextEditingController();
  final differencial_general = TextEditingController();
  final prevoir_un_differentiel_general = TextEditingController();
  final limiteur = TextEditingController();
  final prevoir_un_limiteur = TextEditingController();
  final test_de_la_terre = TextEditingController();
  final nbr_de_metre_de_cable_a_prevoir = TextEditingController();
  final type_de_cable = TextEditingController();
  final modem_est_dans_la_meme_piece_que_londuleur = TextEditingController();
  final tranche = TextEditingController();
  final mot_de_passe_wifi = TextEditingController();
  late Map dataList = {};

  // final nombre_de_metre_de_tranche = TextEditingController();
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

  modifier_ordre() async {
    if (nom.text.isNotEmpty) {
      final token = prefs.getString('refresh');
      Map<String, dynamic> jwtdecoder = JwtDecoder.decode(token!);
      print(widget.id);
      var regbody = {
        "mot_de_passe_wifi": mot_de_passe_wifi.text,
        "modem_est_dans_la_meme_piece_que_londuleur":
            modem_est_dans_la_meme_piece_que_londuleur.text,
        "tranche": tranche.text,
        "type_de_cable": type_de_cable.text,
        "nbr_de_metre_de_cable_a_prevoir": nbr_de_metre_de_cable_a_prevoir.text,
        "test_de_la_terre": test_de_la_terre.text,
        "coffret_general_conforme": coffret_general_conforme.text,
        "prevoir_un_limiteur": prevoir_un_limiteur.text,
        "limiteur": limiteur.text,
        "prevoir_un_differentiel_general": prevoir_un_differentiel_general.text,
        // "differencial_general": differencial_general.text,
        "ajout_coffret_supp": ajout_coffret_supp.text,
        "statut_vt": statut_vt.text,
        "commentaire_technicien": commentaire_technicien.text,
        "vt_effectue_par": vt_effectue_par.text,
        "date_de_la_vt": date_de_la_vt.text,
        "condition_de_paiement": condition_de_paiement.text,
        "le_projet_sera_finance_par": le_projet_sera_finance_par.text,
        "nombres_de_metres_du_modem_a_lonuduleur":
            nombres_de_metres_du_modem_a_lonuduleur.text,
        "le_modem_est_il_dans_la_meme_piece_que_londuleur":
            le_modem_est_il_dans_la_meme_piece_que_londuleur.text,
        "le_client_souheite_il_le_monitoring":
            le_client_souheite_il_le_monitoring.text,
        "nombre_de_metres_entre_onduleur_et_panneaux":
            nombre_de_metres_entre_onduleur_et_panneaux.text,
        "le_client_se_charge_de_gaine": le_client_se_charge_de_gaine.text,
        "nombre_de_metre_de_tranche": nombre_de_metre_de_tranche.text,
        // "tranchee": tranchee.text,
        "coffret_20_cm_disponible": coffret_20_cm_disponible.text,
        "pressence_differentiel_general": pressence_differentiel_general.text,
        "prise_de_terre_controle_5_derniere_annes":
            prise_de_terre_controle_5_derniere_annes.text,
        // "etat_de_linstalation": etat_de_linstalation.text,
        // "Espace_pres_du_coffret_pour_londuleur_meme_piece":
        //     Espace_pres_du_coffret_pour_londuleur_meme_piece.text,
        "gaine_technique_present": gaine_technique_present.text,
        "enphase": Enphase.text,
        "Nombre_doptimiseur": Nombre_doptimiseur.text,
        "onduleur_3": onduleur_3.text,
        "onduleur_2": onduleur_2.text,
        "onduleur_1": onduleur_1.text,
        "type_de_compteur": type_de_compteur.text,
        "nombre_ppv_toiture_3": nombre_ppv_toiture_3.text,
        "acces_libre_le_jour_du_chantier": acces_libre_le_jour_du_chantier.text,
        "si_non_decrire_la_situation": si_non_decrire_la_situation.text,
        "si_a_larriere_yatil_un_acces": si_a_larriere_yatil_un_acces.text,
        "les_panneaux_doivent_etre_installe":
            les_panneaux_doivent_etre_installe.text,
        "etat_du_toit": etat_du_toit.text,
        "si_7m_nacelle": si_7m_nacelle.text,
        "hauteur_sous_corniche": hauteur_sous_corniche.text,
        "orientation": orientation.text,
        "nombre_ppv_toiture_2": nombre_ppv_toiture_2.text,
        // "tuile_rechange": tuile_rechange.text,
        "type_de_corniche": type_de_corniche.text,
        "sous_toiture": sous_toiture.text,
        // "toiture_1": toiture_1.text,
        "nombre_ppv_toiture_1": nombre_ppv_toiture_1.text,
        "nombre_pan_de_toiture": nombre_pan_de_toiture.text,
        // "type_de_range_ppv": type_de_range_ppv.text,
        // "type_pvv": type_pvv.text,
        "nombre_ppv": nomvre_ppv.text,
        "remarque_1": remarque.text,
        "adress_de_livraison_cp": adress_de_livraison_cp.text,
        "adress_de_livraison_localite": adress_de_livraison_localite.text,
        "adress_de_livraison_adress": adress_de_livraison_adress.text,
        "adress_de_facturation_localite": adress_de_facturation_localite.text,
        "adress_de_facturation_adress": adress_de_facturation_adress.text,
        "adress_de_facturation_cp": adress_de_facturation_cp.text,
        "ntva": ntva.text,
        "ncompteur": ncompteur.text,
        "posted_by": jwtdecoder["user_id"].toString(),
        "nom": nom.text,
        "date_de_visite": date_de_visite.text,
        "prenom": prenom.text,
        'email': email.text,
        "adresse": adresse.text,
        "ntel": ntel.text,
        "cp": cp.text,
        "localite": localite.text,
        "ngsm": ngsm.text,
        "nom_de_societe": nom_de_societe.text,
        "forme_juridique": forme_juridique.text,
        "date_de_signature": date_de_signature.text,
        "ean54145": ean54145.text,
      };

      print(jsonEncode(regbody));

      var response = await http.put(
          Uri.parse("https://sirinelec.be/api/PutOrdre/${widget.id}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      print(response.body);
      Navigator.pop(context);
    }
    ;
  }

  retrieveInfo() async {
    var response = await http.get(
        Uri.parse('https://sirinelec.be/api/GetOrderDetails/${widget.id}'));

    if (response.statusCode == 200) {
      dataList = json.decode(response.body);
      // deleted = dataList["deleted"];
      // // Parse JSON here

      print(dataList["deleted"]);

      // dataList.remove("id");
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modifier"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              modifier_ordre();
            },
            label: Text("Envoyer la modification"),
            icon: Icon(Icons.edit)),
        body: FutureBuilder(
            future: retrieveInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is loading, you can display a loading indicator.
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurs, you can display an error message.
                return Text('Error: ${snapshot.error}');
              } else {
                // Data has been successfully loaded, you can display it here.
                return SingleChildScrollView(
                    child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nom..text = dataList["nom"] ?? '',
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nom: ',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: prenom..text = dataList["prenom"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Prenom: ',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: email..text = dataList["email"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Email: ',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: ntel..text = dataList["ntel"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Ntel: ',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adresse..text = dataList["adresse"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adresse: ',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      // initialValue: "2000-1-1",

                      controller: date_de_visite
                        ..text = dataList["date_de_visite"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Date de visite:         yyyy-mm-dd ',
                        label: Text("Date de visite"),
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: cp..text = dataList["cp"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Cp:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: localite..text = dataList["localite"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Localite:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nom_de_societe
                        ..text = dataList["nom_de_societe"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nom de societe:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: forme_juridique
                        ..text = dataList["forme_juridique"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Forme juridique:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: date_de_signature
                        ..text = dataList["date_de_signature"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Date de signature:',
                        label: Text("Date de signature"),

                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: ean54145..text = dataList["ean54145"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'EAN:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: ncompteur..text = dataList["ncompteur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Ncompteur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: ntva..text = dataList["ntva"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Ntva:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adress_de_facturation_adress
                        ..text = dataList["adress_de_facturation_adress"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adress de facturation,  adress:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adress_de_facturation_cp
                        ..text = dataList["adress_de_facturation_cp"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adresse de facturation, cp:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adress_de_facturation_localite
                        ..text = dataList["adress_de_facturation_localite"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adress de facturation, localite:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adress_de_livraison_adress
                        ..text = dataList["adress_de_livraison_adress"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adress de livraison, adress:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adress_de_livraison_localite
                        ..text = dataList["adress_de_livraison_localite"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adress de livraison, localite:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: adress_de_livraison_cp
                        ..text = dataList["adress_de_livraison_cp"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Adress de livraison, Cp:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 50, bottom: 0),
                  //   child: TextField(
                  //     controller: remarque..text = dataList["remarque_1"],
                  //     style: TextStyle(color: Colors.green), // Text color
                  //     decoration: InputDecoration(
                  //       hintText: 'Remarque:',
                  //       // hintStyle: TextStyle(color: Colors), // Hint text color
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Colors.green), // Focused border color
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nomvre_ppv..text = dataList["nombre_ppv"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nombre ppv:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: type_pvv..text = dataList["type_ppv"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Type pvv:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 50, bottom: 0),
                  //   child: TextField(
                  //     controller: type_de_range_ppv
                  //       ..text = dataList["type_de_range_ppv"],
                  //     style: TextStyle(color: Colors.green), // Text color
                  //     decoration: InputDecoration(
                  //       hintText: 'Type de range ppv:',
                  //       // hintStyle: TextStyle(color: Colors), // Hint text color
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Colors.green), // Focused border color
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombre_pan_de_toiture
                        ..text = dataList["nombre_pan_de_toiture"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nombre pan de toiture:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombre_ppv_toiture_1
                        ..text = dataList["nombre_ppv_toiture_1"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nombre ppv toiture 1:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: toiture_1..text = dataList["toiture"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Toiture 1:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: sous_toiture..text = dataList["sous_toiture"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Sous toiture:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: type_de_corniche
                        ..text = dataList["type_de_corniche"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Type de corniche:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: tuile_rechange
                        ..text = dataList["tuile_rechage"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Tuile rechange:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombre_ppv_toiture_2
                        ..text = dataList["nombre_ppv_toiture_2"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nombre ppv toiture 2:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: orientation..text = dataList["orientation"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Orientation:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: hauteur_sous_corniche
                        ..text = dataList["hauteur_sous_corniche"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Hauteur sous corniche:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: si_7m_nacelle
                        ..text = dataList["si_de7m_nacelle"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Si 7m nacelle:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: etat_du_toit..text = dataList["etat_du_toit"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Etat du toit:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: les_panneaux_doivent_etre_installe
                        ..text =
                            dataList["les_panneaux_doivent_etre_installes"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Les_panneaux doivent etre installe:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 50, bottom: 0),
                  //   child: TextField(
                  //     controller: si_a_larriere_yatil_un_acces
                  //       ..text = dataList["acces_par_arriere_pour_passé"],
                  //     style: TextStyle(color: Colors.green), // Text color
                  //     decoration: InputDecoration(
                  //       hintText: 'si_a_larriere_yatil_un_acces:',
                  //       // hintStyle: TextStyle(color: Colors), // Hint text color
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Colors.green), // Focused border color
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: si_non_decrire_la_situation
                        ..text = dataList["si_pas_dacces_decrire_la_situation"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'si_non_decrire_la_situation:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: acces_libre_le_jour_du_chantier
                        ..text = dataList["acces_libre_le_jour_du_chantier"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'acces_libre_le_jour_du_chantier:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombre_ppv_toiture_3
                        ..text = dataList["nombre_ppv_toiture_3"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'nombre_ppv_toiture_3:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: type_de_compteur
                        ..text = dataList["type_de_compteur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'type_de_compteur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: onduleur_1..text = dataList["onduleur_1"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'onduleur_1:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: onduleur_2..text = dataList["onduleur_2"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'onduleur_2:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: onduleur_3..text = dataList["onduleur_3"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'onduleur_3:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: Nombre_doptimiseur
                        ..text = dataList["Nombre_doptimiseur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Nombre_doptimiseur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: Enphase..text = dataList["enphase"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'Enphase:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: gaine_technique_present
                        ..text = dataList["gaine_technique_present"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'gaine_technique_present:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 50, bottom: 0),
                  //   child: TextField(
                  //     controller: Espace_pres_du_coffret_pour_londuleur_meme_piece
                  //       ..text = dataList[
                  //           "Espace_pres_du_coffret_pour_londuleur_meme_piece"],
                  //     style: TextStyle(color: Colors.green), // Text color
                  //     decoration: InputDecoration(
                  //       hintText:
                  //           'Espace_pres_du_coffret_pour_londuleur_meme_piece:',
                  //       // hintStyle: TextStyle(color: Colors), // Hint text color
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Colors.green), // Focused border color
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 50, bottom: 0),
                  //   child: TextField(
                  //     controller: etat_de_linstalation
                  //       ..text = dataList["etat_de_linstalation"],
                  //     style: TextStyle(color: Colors.green), // Text color
                  //     decoration: InputDecoration(
                  //       hintText: 'etat_de_linstalation:',
                  //       // hintStyle: TextStyle(color: Colors), // Hint text color
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Colors.green), // Focused border color
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: prise_de_terre_controle_5_derniere_annes
                        ..text = dataList[
                            "prise_de_terre_controle_5_derniere_annes"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'prise_de_terre_controle_5_derniere_annes:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: pressence_differentiel_general
                        ..text = dataList["pressence_differentiel_general"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'pressence_differentiel_general:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: coffret_20_cm_disponible
                        ..text = dataList["coffret_20_cm_disponible"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'coffret_20_cm_disponible:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: tranchee..text = dataList["tranche"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'tranchee:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombre_de_metre_de_tranche
                        ..text = dataList["nombre_de_metre_de_tranche"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'nombre_de_metre_de_tranche:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: le_client_se_charge_de_gaine
                        ..text = dataList["le_client_se_charge_de_gaine"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'le_client_se_charge_de_gaine:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombre_de_metres_entre_onduleur_et_panneaux
                        ..text = dataList[
                            "nombre_de_metres_entre_onduleur_et_panneaux"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText:
                            'nombre_de_metres_entre_onduleur_et_panneaux:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: le_client_souheite_il_le_monitoring
                        ..text =
                            dataList["le_client_souheite_il_le_monitoring"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'le_client_souheite_il_le_monitoring:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: le_modem_est_il_dans_la_meme_piece_que_londuleur
                        ..text = dataList[
                            "le_modem_est_il_dans_la_meme_piece_que_londuleur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText:
                            'le_modem_est_il_dans_la_meme_piece_que_londuleur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nombres_de_metres_du_modem_a_lonuduleur
                        ..text =
                            dataList["nombres_de_metres_du_modem_a_lonuduleur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'nombres_de_metres_du_modem_a_lonuduleur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: le_projet_sera_finance_par
                        ..text = dataList["le_projet_sera_finance_par"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'le_projet_sera_finance_par:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: condition_de_paiement
                        ..text = dataList["condition_de_paiement"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'condition_de_paiement:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: date_de_la_vt
                        ..text = dataList["date_de_la_vt"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'date_de_la_vt:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: vt_effectue_par
                        ..text = dataList["vt_effectue_par"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'vt_effectue_par:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: commentaire_technicien
                        ..text = dataList["commentaire_technicien"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'commentaire_technicien:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: statut_vt..text = dataList["statut_vt"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'statut_vt:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: coffret_general_conforme
                        ..text = dataList["coffret_general_conforme"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'coffret_general_conforme:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: ajout_coffret_supp
                        ..text = dataList["ajout_coffret_supp"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'ajout_coffret_supp:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: differencial_general
                        ..text = dataList["differenciel_general"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'differencial_general:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: prevoir_un_differentiel_general
                        ..text = dataList["prevoir_un_differentiel_general"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'prevoir_un_differentiel_general:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: limiteur..text = dataList["limiteur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'limiteur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: prevoir_un_limiteur
                        ..text = dataList["prevoir_un_limiteur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'prevoir_un_limiteur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: test_de_la_terre
                        ..text = dataList["test_de_la_terre"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'test_de_la_terre:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: nbr_de_metre_de_cable_a_prevoir
                        ..text = dataList["nbr_de_metre_de_cable_a_prevoir"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'nbr_de_metre_de_cable_a_prevoir:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: type_de_cable
                        ..text = dataList["type_de_cable"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'type_de_cable:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: tranche..text = dataList["tranche"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'tranche:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: modem_est_dans_la_meme_piece_que_londuleur
                        ..text = dataList[
                            "modem_est_dans_la_meme_piece_que_londuleur"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'modem_est_dans_la_meme_piece_que_londuleur:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 50, bottom: 0),
                    child: TextField(
                      controller: mot_de_passe_wifi
                        ..text = dataList["mot_de_passe_wifi"],
                      style: TextStyle(color: Colors.green), // Text color
                      decoration: InputDecoration(
                        hintText: 'mot_de_passe_wifi:',
                        // hintStyle: TextStyle(color: Colors), // Hint text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.green), // Focused border color
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 100,
                  )
                ]));
              }
            }));
  }
}









// [
//     {
//         "id": 61,
//         "deleted": false,
//         "nom": "t",
//         "prenom": "t",
//         "adresse": "t@gmail.com",
//         "cp": "t",
//         "localite": "t",
//         "ngsm": "t",
//         "ntel": "292288",
//         "email": "f@gmail.com",
//         "nom_de_societe": "t",
//         "forme_juridique": "t",
//         "date_de_visite": "2222-01-01",
//         "date_de_signature": "2000-11-11",
//         "ean54145": "3434",
//         "ncompte": "3",
//         "bic": "3",
//         "grd": "3",
//         "ncompteur": "3",
//         "ntva": "3",
//         "adress_de_facturation_adress": "3",
//         "adress_de_facturation_cp": "3",
//         "adress_de_facturation_localite": "3",
//         "adress_de_livraison_adress": "3",
//         "adress_de_livraison_cp": "3",
//         "adress_de_livraison_localite": "3",
//         "remarque_1": "3",
//         "nombre_ppv": "3",
//         "type_ppv": "3",
//         "nombre_de_range_ppv": "3",
//         "nombre_pan_de_toiture": "3",
//         "nombre_ppv_toiture_1": "3",
//         "toiture": "3",
//         "toiture_3": "3",
//         "sous_toiture": "oui",
//         "type_de_corniche": "3",
//         "tuile_rechage": "3",
//         "nombre_ppv_toiture_2": "3",
//         "orientation": "NE",
//         "hauteur_sous_corniche": "3",
//         "si_de7m_nacelle": "oui",
//         "etat_du_toit": "3",
//         "les_panneaux_doivent_etre_installes": "oui",
//         "acces_par_arriere_pour_passé": "oui",
//         "si_pas_dacces_decrire_la_situation": "3",
//         "acces_libre_le_jour_du_chantier": "3",
//         "nombre_ppv_toiture_3": "3",
//         "onduleur_1": "3",
//         "onduleur_2": "3",
//         "onduleur_3": "3",
//         "Nombre_doptimiseur": "3",
//         "enphase": "3",
//         "gaine_technique_present": "oui",
//         "espace_pres_du_coffret_pour_onduleur_meme_piece": "oui",
//         "etat_de_linstallation": "3",
//         "prise_de_terre_controle_5_derniere_annes": "oui",
//         "pressence_differentiel_general": "oui",
//         "passage_de_cable_nbre_piece_a_traverser": "3",
//         "coffret_20_cm_disponible": "non",
//         "tranche": "non",
//         "nombre_de_metre_de_tranche": "3",
//         "le_client_se_charge_de_gaine": "non",
//         "nombre_de_metres_entre_onduleur_et_panneaux": "3",
//         "le_client_souheite_il_le_monitoring": "non",
//         "le_modem_est_il_dans_la_meme_piece_que_londuleur": "3",
//         "nombres_de_metres_du_modem_a_lonuduleur": "3",
//         "le_projet_sera_finance_par": "3",
//         "condition_de_paiement": "3",
//         "date_de_la_vt": "3",
//         "vt_effectue_par": "3",
//         "commentaire_technicien": "3",
//         "statut_vt": "3",
//         "coffret_general_conforme": "3",
//         "type_de_cable": "3",
//         "ajout_coffret_supp": "3",
//         "type_de_compteur": "3",
//         "differenciel_general": "3",
//         "prevoir_un_differentiel_general": "3",
//         "limiteur": "3",
//         "prevoir_un_limiteur": "3",
//         "test_de_la_terre": "3",
//         "nbr_de_metre_de_cable_a_prevoir": "3",
//         "monitoring": "3",
//         "modem_est_dans_la_meme_piece_que_londuleur": "3",
//         "mot_de_passe_wifi": "3",
//         "type_de_toitur_prevu": "3",
//         "type_toiture_prevu_a_la_vt": "3",
//         "nbr_de_ppv": "3",
//         "nbr_de_ppv_a_la_vt": "3",
//         "ppv_en_portait": "3",
//         "ppv_en_paysage": "3",
//         "ppv_en_toiture_plate": "3",
//         "ppv_en_chevalet_jardin": "3",
//         "ppv_en_structure_jardin": "3",
//         "sous_toiture_2": "3",
//         "le_client_a_des_ardoise_tuiles_de_rechange": "3",
//         "nbr_dardoises_tuiles_rechange": "3",
//         "remarque_du_chantier": "3",
//         "post_date": "2023-10-20",
//         "posted_by": 1
//     }
// ]