import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';

import '../common/custom_appbar.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const CustomAppBar(title: 'siret : 94276844100019 '),
    drawer: MediaQuery.of(context).size.width <= 750
    ? const CustomDrawer()
        : null,
    body:Stack(
      children: [

        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Les Petites Créas d'Alexia",
                style: titleStyleLarge(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                """Bonjour et bienvenue chez Les Petites Créas d’Alexia ✨

Je m’appelle Alexia, créatrice passionnée d’objets faits main. 
À travers ce projet, je vous propose un univers doux et coloré, rempli de petites créations artisanales réalisées avec soin, patience et beaucoup d’amour.

Je travaille différents matériaux et techniques pour donner vie à des objets uniques ou personnalisés, notamment :
• la couture (accessoires, déco, créations textiles),
• la création en papier (cartes, décorations, papeterie créative),
• le transfert d’image sur tissu, mug, bois ou autre support,
• le gravage sur verre pour des objets élégants et sur mesure,
• et bien sûr, la personnalisation d’objets variés selon vos envies.

Que ce soit pour un cadeau, une décoration originale ou un objet à votre image, je suis à votre écoute pour créer quelque chose qui vous ressemble.

Merci de votre visite et bonne découverte !""",
                style: textStyleText(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    )
    );
  }
}
