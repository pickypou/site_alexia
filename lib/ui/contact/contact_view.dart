import 'package:flutter/material.dart';

import '../../theme.dart';
import '../common/custom_appbar.dart';
import '../common/footer.dart';
import 'form_contact.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {

      return Scaffold(
          appBar: const CustomAppBar(title: 'siret : 94276844100019 '),
    drawer: MediaQuery.of(context).size.width <= 750
    ? const CustomDrawer()
        : null,
    body:SingleChildScrollView(
    child:
    Padding(
        padding: const EdgeInsets.all(25),

        // bottomNavigationBar: Footer(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            Align(
              alignment: Alignment.center,
              child: Text("Nous contacter", style: titleStyleMedium(context)),
            ),

            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section gauche : Images
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const SizedBox(height: 35),
                      Text(
                        '13 rue des martyrs',
                        style: textStyleText(context),
                      ),

                      const SizedBox(height: 10),
                      Text('59113 Seclin', style: textStyleText(context)),
                      const SizedBox(height: 35),

                    ],
                  ),
                ),
                const SizedBox(width: 40),
                // Section droite : Formulaire
                Expanded(flex: 2, child: FormContact()),
              ],
            ),

            //const SizedBox(height: 50),

            Footer(),
          ],
        ),
    )
    )
      );
    }
  }
