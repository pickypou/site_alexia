import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/check_user_connection.dart';
import '../../theme.dart';
import '../common/custom_buttom.dart';



class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.instance<FirebaseAuth>();
    Size size = MediaQuery.sizeOf(context);
    if (size.width < 749) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onSurface,
          title: const Text('Accueil'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                auth.signOut().then((_) {
                  debugPrint('Déconnexion réussie');
                  context.go('/');
                });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Bienvenue sur l\'administration ',
                style: titleStyleMedium(context),
                textAlign: TextAlign.center,
              ),
              Text(
               "D'Alexia",
                style: titleStyleMedium(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 70),
              /*CustomButton(
                onPressed: () => GoRouter.of(context).go('/addUser'),
                label: 'Je crée un compte',
              ),*/
              const SizedBox(height: 70), // Remplacez par :
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              CustomButton(
                onPressed: () {
                  checkUserConnection(context);
                },
                label: 'Connexion',
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.onSurface,
          title: const Text('Accueil'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                auth.signOut().then((_) {
                  debugPrint('Déconnexion réussie');
                  context.go('/');
                });
              },
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          color: theme.primaryColor,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10), // Ajustement du padding
              child: Column(
                mainAxisSize:
                MainAxisSize.min, // Gère uniquement la hauteur requise
                children: [
                 // Réduction de l'espace ici
                  Text(
                    'Bienvenue sur l\'administration',
                    style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "D'Alexia",
                    style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15), // Ajustement de l'espace
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                          onPressed: () => GoRouter.of(context).go('/addUser'),
                          label: 'Je crée un compte'),
                      const SizedBox(
                        width: 35,
                      ),
                      CustomButton(
                        onPressed: () {
                          checkUserConnection(context);
                        },
                        label: 'Connexion',
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}