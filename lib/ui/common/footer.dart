import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme.dart';

class Footer extends StatelessWidget {
  final double? fontSize;
  const Footer({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    // Obtenir la largeur de l'écran pour la responsivité
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Container(
      constraints: BoxConstraints(
        // Hauteur adaptative selon la taille d'écran
        maxHeight: isSmallScreen ? 150 : 80,
        minHeight: 56.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: theme.colorScheme.primary, thickness: 1),
          Expanded(
            child: Padding(
              // Padding adaptatif
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16 : 45,
                vertical: 10,
              ),
              // Choisir la disposition en fonction de la taille d'écran
              child:
              isSmallScreen
                  ? _buildSmallScreenLayout(context)
                  : _buildLargeScreenLayout(context),
            ),
          ),
        ],
      ),
    );
  }

  // Disposition pour petits écrans
  Widget _buildSmallScreenLayout(BuildContext context) {
    return Wrap(
      children: [
        // L'image est déjà dimensionnée dans le composant ClickableImage

        const SizedBox(height: 8),
        Text(
          "© 2025 Les.petites.créas.d'alexia tous droits réservés",
          style: textStyleTextAccueil(context).copyWith(fontSize: 10),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 4),
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
          Text('Céation Ludovic SPYSSCHAERT', style:textStyleText(context).copyWith(fontSize: 10), textAlign: TextAlign.end,),
        ),
      ],
    );
  }

  // Disposition pour écrans moyens et grands
  Widget _buildLargeScreenLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Flexible(
          flex: 2,
          child: Text(
            "© 2025 Les.petites.créas.d'alexia tous droits réservés",
            style: textStyleTextAccueil(context),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          flex: 1,
          child:  TextButton(
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
            Text('Céation Ludovic SPYSSCHAERT', style:textStyleText(context).copyWith(fontSize: 10), textAlign: TextAlign.end,),
          ),
        ),
      ],
    );
  }
}