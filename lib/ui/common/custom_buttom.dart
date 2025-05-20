import 'package:flutter/material.dart';

import '../../theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double? fontSize;
  final VoidCallback? onPressed; // Rendre le callback optionnel

  const CustomButton({
    required this.label,
    this.onPressed, // Le callback est optionnel
    this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.sizeOf(context);
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 60 : 20);

    // Calculez la largeur souhaitée en fonction de la largeur de l'écran.
    double buttonWidth = screenWidth * 0.8;
    if (screenWidth > 500) {
      buttonWidth = 300.0; // Comme pour le CustomTextField
    }

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(vertical: 11),
            ),
            backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
              if (states.contains(WidgetState.pressed)) {
                return theme.colorScheme.onSurface; // Fond quand pressé
              }
              return theme.colorScheme.onSurface; // Fond par défaut
            }),
            shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((
                states,
                ) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(
                  color: theme.colorScheme.primary,
                  width:
                  states.contains(WidgetState.pressed)
                      ? 3.0
                      : 3.0, // Bordure dynamique
                ),
              );
            }),
          ),
          onPressed:
          onPressed ?? () {}, // Fonction par défaut si `onPressed` est null
          child: Builder(
            builder: (context) {
              // Dynamique selon l'état pressé
              final isPressed =
                  ElevatedButtonTheme.of(
                    context,
                  ).style?.backgroundColor?.resolve({WidgetState.pressed}) !=
                      null;
              return Text(
                label,
                style: TextStyle(
                  fontSize: calculatedFontSize,
                  color:
                  isPressed
                      ? theme
                      .colorScheme
                      .primary // Texte quand pressé
                      : theme.colorScheme.secondary, // Texte par défaut
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}