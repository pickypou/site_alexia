import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_appbar_admin.dart';

import '../../../core/utils/access_checker.dart';
import '../../../theme.dart';



class AccountView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const AccountView({super.key, required this.userData});

  @override
  AccountViewState createState() => AccountViewState();
}

class AccountViewState extends State<AccountView> {
  bool isAdmin = false; // Par défaut, l'utilisateur n'est pas administrateur
  bool isLoading = true; // Indique si la vérification est en cours

  @override
  void initState() {
    super.initState();
    _checkAdminAccess();
  }

  Future<void> _checkAdminAccess() async {
    final hasAdminAccess = await hasAccess(); // Appelle la fonction asynchrone
    setState(() {
      isAdmin = hasAdminAccess;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.instance<FirebaseAuth>();

    if (isLoading) {
      // Affiche un indicateur de chargement pendant la vérification
      return Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar:  CustomAppBarAdmin(title: ''),
      drawer:
      MediaQuery.of(context).size.width <= 750
          ? const CustomDrawerAdmin()
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Ajout de marges latérales
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Étire les enfants sur toute la largeur
            children: [
              const SizedBox(height: 20),
              Text(
                "Bonjour ${widget.userData['userName']}",
                style: titleStyleLarge(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              Image.asset(
                'assets/images/logo_1.jpg',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const SizedBox(height: 50),
              if (isAdmin) ...[
                Text("J'enregistre où je supprime tout ce que je veux !!!!", style: textStyleText(context),
                textAlign: TextAlign.center,
                )

                  ],



              ],

          ),
        ),
      ),
    );
  }
}