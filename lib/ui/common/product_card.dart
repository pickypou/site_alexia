import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Vérifier si l'image est valide avant d'ouvrir le dialog
        if (imageUrl.isNotEmpty && _isValidImageUrl(imageUrl)) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: InteractiveViewer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: _buildNetworkImage(
                        imageUrl,
                        fit: BoxFit.contain,
                        showPlaceholder: false,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // Afficher un message si pas d'image
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Aucune image disponible pour cette création'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 1, color: theme.colorScheme.secondary),
        ),
        elevation: 0,
        color: theme.colorScheme.error,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Image avec gestion d'erreurs
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _buildNetworkImage(
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: textStyleText(context),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$price €',
                        style: textStyleText(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour construire l'image avec gestion d'erreurs
  Widget _buildNetworkImage(
      String imageUrl, {
        double? width,
        double? height,
        BoxFit? fit,
        bool showPlaceholder = true,
      }) {
    // Si pas d'URL ou URL vide
    if (imageUrl.isEmpty) {
      return _buildPlaceholder(width, height, showPlaceholder);
    }

    // Si URL invalide
    if (!_isValidImageUrl(imageUrl)) {
      return _buildErrorWidget(width, height, showPlaceholder);
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint("❌ Erreur de chargement d'image: $error");
        debugPrint("🔗 URL: $imageUrl");
        return _buildErrorWidget(width, height, showPlaceholder);
      },
    );
  }

  // Widget de placeholder quand pas d'image
  Widget _buildPlaceholder(double? width, double? height, bool show) {
    if (!show) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            color: Colors.grey.shade400,
            size: width != null ? width * 0.3 : 30,
          ),
          if (width == null || width > 80) ...[
            const SizedBox(height: 4),
            Text(
              'Pas d\'image',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Widget d'erreur quand l'image ne se charge pas
  Widget _buildErrorWidget(double? width, double? height, bool show) {
    if (!show) {
      return Container(
        width: width,
        height: height,
        color: Colors.red.shade200,
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image,
            color: Colors.red.shade600,
            size: width != null ? width * 0.3 : 30,
          ),
          if (width == null || width > 80) ...[
            const SizedBox(height: 4),
            Text(
              'Erreur',
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Vérifier si l'URL est valide
  bool _isValidImageUrl(String url) {
    if (url.isEmpty) return false;

    // Vérifier que c'est une URL Firebase Storage valide
    if (!url.contains('firebasestorage.googleapis.com')) return false;

    // Vérifier que ce n'est pas du HTML
    if (url.contains('<!DOCTYPE') || url.contains('<html>')) return false;

    return true;
  }
}