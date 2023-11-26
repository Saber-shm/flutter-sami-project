import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AjouterOrdre extends StatefulWidget {
  AjouterOrdre({super.key});

  @override
  State<AjouterOrdre> createState() => _AjouterOrdreState();
}

class _AjouterOrdreState extends State<AjouterOrdre> {
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

  ajouter_ordre() async {
    if (nom.text.isNotEmpty) {
      final token = prefs.getString('refresh');
      Map<String, dynamic> jwtdecoder = JwtDecoder.decode(token!);
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
        "differencial_general": differencial_general.text,
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
        "tranchee": tranchee.text,
        "coffret_20_cm_disponible": coffret_20_cm_disponible.text,
        "pressence_differentiel_general": pressence_differentiel_general.text,
        "prise_de_terre_controle_5_derniere_annes":
            prise_de_terre_controle_5_derniere_annes.text,
        "etat_de_linstalation": etat_de_linstalation.text,
        "Espace_pres_du_coffret_pour_londuleur_meme_piece":
            Espace_pres_du_coffret_pour_londuleur_meme_piece.text,
        "gaine_technique_present": gaine_technique_present.text,
        "Enphase": Enphase.text,
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
        "tuile_rechange": tuile_rechange.text,
        "type_de_corniche": type_de_corniche.text,
        "sous_toiture": sous_toiture.text,
        "toiture_1": toiture_1.text,
        "nombre_ppv_toiture_1": nombre_ppv_toiture_1.text,
        "nombre_pan_de_toiture": nombre_pan_de_toiture.text,
        // "type_de_range_ppv": type_de_range_ppv.text,
        "type_pvv": type_pvv.text,
        "nomvre_ppv": nomvre_ppv.text,
        "remarque": remarque.text,
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

      var response = await http.post(
          Uri.parse("https://sirinelec.be/api/PostOrder/"),
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
          title: Text("Ajouter Ordre:"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              ajouter_ordre();
            },
            label: Text("Envoyer l'ordre"),
            icon: Icon(Icons.add_box_rounded)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 50, bottom: 0),
                child: TextField(
                  controller: nom,
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
                  controller: prenom,
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
                  controller: email,
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
                  controller: ntel,
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
                  controller: adresse,
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

                  controller: date_de_visite..text = "2000-1-1",
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
                  controller: cp,
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
                  controller: localite,
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
                  controller: nom_de_societe,
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
                  controller: forme_juridique,
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
                  controller: date_de_signature..text = "2000-1-1",
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
                  controller: ean54145,
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
                  controller: ncompteur,
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
                  controller: ntva,
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
                  controller: adress_de_facturation_adress,
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
                  controller: adress_de_facturation_cp,
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
                  controller: adress_de_facturation_localite,
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
                  controller: adress_de_livraison_adress,
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
                  controller: adress_de_livraison_localite,
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
                  controller: adress_de_livraison_cp,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 50, bottom: 0),
                child: TextField(
                  controller: remarque,
                  style: TextStyle(color: Colors.green), // Text color
                  decoration: InputDecoration(
                    hintText: 'Remarque:',
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
                  controller: nomvre_ppv,
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
                  controller: type_pvv,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 50, bottom: 0),
                child: TextField(
                  controller: type_de_range_ppv,
                  style: TextStyle(color: Colors.green), // Text color
                  decoration: InputDecoration(
                    hintText: 'Type de range ppv:',
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
                  controller: nombre_pan_de_toiture,
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
                  controller: nombre_ppv_toiture_1,
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
                  controller: toiture_1,
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
                  controller: sous_toiture,
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
                  controller: type_de_corniche,
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
                  controller: tuile_rechange,
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
                  controller: nombre_ppv_toiture_2,
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
                  controller: orientation,
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
                  controller: hauteur_sous_corniche,
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
                  controller: si_7m_nacelle,
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
                  controller: etat_du_toit,
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
                  controller: les_panneaux_doivent_etre_installe,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 50, bottom: 0),
                child: TextField(
                  controller: si_a_larriere_yatil_un_acces,
                  style: TextStyle(color: Colors.green), // Text color
                  decoration: InputDecoration(
                    hintText: 'si_a_larriere_yatil_un_acces:',
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
                  controller: si_non_decrire_la_situation,
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
                  controller: acces_libre_le_jour_du_chantier,
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
                  controller: nombre_ppv_toiture_3,
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
                  controller: type_de_compteur,
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
                  controller: onduleur_1,
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
                  controller: onduleur_2,
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
                  controller: onduleur_3,
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
                  controller: Nombre_doptimiseur,
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
                  controller: Enphase,
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
                  controller: gaine_technique_present,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 50, bottom: 0),
                child: TextField(
                  controller: Espace_pres_du_coffret_pour_londuleur_meme_piece,
                  style: TextStyle(color: Colors.green), // Text color
                  decoration: InputDecoration(
                    hintText:
                        'Espace_pres_du_coffret_pour_londuleur_meme_piece:',
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
                  controller: etat_de_linstalation,
                  style: TextStyle(color: Colors.green), // Text color
                  decoration: InputDecoration(
                    hintText: 'etat_de_linstalation:',
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
                  controller: prise_de_terre_controle_5_derniere_annes,
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
                  controller: pressence_differentiel_general,
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
                  controller: coffret_20_cm_disponible,
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
                  controller: tranchee,
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
                  controller: nombre_de_metre_de_tranche,
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
                  controller: le_client_se_charge_de_gaine,
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
                  controller: nombre_de_metres_entre_onduleur_et_panneaux,
                  style: TextStyle(color: Colors.green), // Text color
                  decoration: InputDecoration(
                    hintText: 'nombre_de_metres_entre_onduleur_et_panneaux:',
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
                  controller: le_client_souheite_il_le_monitoring,
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
                  controller: le_modem_est_il_dans_la_meme_piece_que_londuleur,
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
                  controller: nombres_de_metres_du_modem_a_lonuduleur,
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
                  controller: le_projet_sera_finance_par,
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
                  controller: condition_de_paiement,
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
                  controller: date_de_la_vt,
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
                  controller: vt_effectue_par,
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
                  controller: commentaire_technicien,
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
                  controller: statut_vt,
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
                  controller: coffret_general_conforme,
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
                  controller: ajout_coffret_supp,
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
                  controller: differencial_general,
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
                  controller: prevoir_un_differentiel_general,
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
                  controller: limiteur,
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
                  controller: prevoir_un_limiteur,
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
                  controller: test_de_la_terre,
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
                  controller: nbr_de_metre_de_cable_a_prevoir,
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
                  controller: type_de_cable,
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
                  controller: tranche,
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
                  controller: modem_est_dans_la_meme_piece_que_londuleur,
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
                  controller: mot_de_passe_wifi,
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
            ],
          ),
        ));
  }
}
