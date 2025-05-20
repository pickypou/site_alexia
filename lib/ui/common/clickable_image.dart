import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableImage extends StatelessWidget {
  final String imagePath;
  final String? route;
  final String? url;

  const ClickableImage({
    super.key,
    required this.imagePath,
    this.route,
    this.url,
  }) : assert(
  route != null || url != null,
  'Vous devez fournir soit une route soit une URL.',
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (route != null) {
          context.go(route!);
        } else if (url != null) {
          await _launchURL(url!);
        }
      },
      child: Image.asset(imagePath, width: 75, height: 75, fit: BoxFit.contain),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw 'Impossible d\'ouvrir l\'URL $urlString';
    }
  }
}