import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback? onTap;



  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
        onTap:  () {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: InteractiveViewer( // permet de zoomer/dézoomer
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrl, // ou Image.network(...) selon ton cas
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
    // pour rendre la carte cliquable
        child:  Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 1, color: theme.colorScheme.secondary)
        ),
        elevation: 0,
        color: theme.colorScheme.error,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyleSmall(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: textStyleText(context),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        )
    );
  }
}
