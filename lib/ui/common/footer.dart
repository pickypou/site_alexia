import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';
import 'clickable_image.dart';

class Footer extends StatelessWidget {
  final double? fontSize;
  const Footer({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 56.0), // Hauteur maximale fixée
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: theme.colorScheme.primary,
            thickness: 1,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClickableImage(
                      imagePath: 'assets/images/logo_1.jpg',
                      route: "/admin"),

                  Flexible(
                    child: Text(
                      "© 2025 Féerique & pétillante tous droits réservés",
                      style: textStyleText(context),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(child:
    TextButton(
    onPressed: () async {
    final Uri url = Uri.parse('https://ludovicspysschaert.fr/');
    if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
    // Tu peux afficher une erreur ici
    throw 'Impossible d’ouvrir l’URL : $url';
    }
    },
    child:
    Text('Création Ludovic SPYSSCHAERT', style:textStyleText(context).copyWith(fontSize: 10), textAlign: TextAlign.end,),
    ),



                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}