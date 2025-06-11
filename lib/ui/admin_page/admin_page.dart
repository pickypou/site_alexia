import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/check_user_connection.dart';
import '../../theme.dart';
import '../common/custom_buttom.dart';



class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          title: TextButton(
            onPressed: () {
              context.go('/');
            },
            child: Text('Accueil', style: textStyleTextAppBar(context),),
          ),
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
                    "De féerique",
                    style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "& Petillante",
                    style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 35,),
                  Image.asset('assets/images/logo_1.jpg', fit: BoxFit.contain, width: 220,),
                  const SizedBox(height: 35), // Ajustement de l'espace
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
