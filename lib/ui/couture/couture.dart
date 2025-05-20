import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/common/footer.dart';
import 'package:les_petite_creations_d_alexia/ui/common/product_card.dart';

import '../common/custom_appbar.dart';

class Couture extends StatelessWidget {
  const Couture({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: const CustomAppBar(title: 'siret : 94276844100019 '),
    drawer: MediaQuery.of(context).size.width <= 750
    ? const CustomDrawer()
    : null,
    body: SingleChildScrollView(
    child:
    Padding(padding: EdgeInsets.all(35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Des créations De couture', style: titleStyleMedium(context),
          textAlign: TextAlign.center,),
          const SizedBox(height: 35,),
          Wrap(
              children: [
                ProductCard(imageUrl: 'assets/images/serviettes.jpg',
                    title: "Des serviettes pour  cuisine ou salle de bain !",
                    description: "Des serviettes cousues avec amour pour donner du pep's à votre cuisine ou salle de bain !"),
                ProductCard(imageUrl: 'assets/images/set_de_table.jpg',
                    title: "Set de table avec emplacement pour couverts",
                    description: "des set de table ou les couvert sont caché !!!"),
                ProductCard(imageUrl: 'assets/images/isotherme.jpg',
                    title: "Sac isotherme pour bouteille 1L",
                    description: "Un sac isotherme a emporté partout en promenade ou au travail"),
                ProductCard(imageUrl: 'assets/images/trousse-1.jpg',
                    title: "Une petite trousse four tout",
                    description: "des mots doux à emporter partout pour celle qu'on aime fort !"
                ),
                ProductCard(imageUrl: 'assets/images/trousse-1.jpg',
                    title: "Une petite trousse four tout",
                    description: "des mots doux à emporter partout pour celle qu'on aime fort !"
                )



              ],
            ),
          Footer()

        ],
      ),
    )
    )
    );
  }
}
