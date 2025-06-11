import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/common/footer.dart';

import '../common/custom_appbar.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      drawer:
          MediaQuery.of(context).size.width <= 750
              ? const CustomDrawer()
              : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Le Monde partagé de la petite fée Crochette by Amandine ",
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "&",
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Les Créas D'Alexia",
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Image.asset(
                  "assets/images/logo_1.jpg",
                  fit: BoxFit.contain,
                  width: 220,
                ),

                const SizedBox(height: 30),
                Text('Deux créatrices , Deux univers ...', style: textStyleText(context),),
                const SizedBox(height: 20),
                Text('Une même passion du fait main.', style: textStyleText(context),),
                const SizedBox(height: 20),
                Text("Bienvenue dans notre monde à 4 mains, où chaque création raconte une histoire Unique. D'un côté, la douceur d'un monde féerique. De l'autre, un tourbillon de couleurs pétillantes. Créer, Créer, Coudre, Broder ou Crocheter, avec amour et fantaisie. Deux styles deux ambiances..."
                  , style: textStyleText(context),),
                const SizedBox(height: 20,),
                Text("Il n'y a pas de frontière entre nos monde, seulement un pont de créativité et d'amitié.", style: textStyleText(context), ),
                const SizedBox(height: 45,),
                Wrap(
                  children: [
                    Text('La fée Crochette alias Amandine n° de siret : 94151489500015 ', style: textStyleText(context),),
                    const SizedBox(width: 80,),
                    Text("Les Créas D'Alexia n° de siret : 9427684400019", style: textStyleText(context),)
                  ],
                ),

                const SizedBox(height: 80),
                Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
