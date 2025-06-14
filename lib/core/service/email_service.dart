import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailService {
  static const String _baseUrl =
      'https://us-central1-alexia-d2307.cloudfunctions.net';

  // Durée d'attente maximale pour la requête
  static const Duration _timeoutDuration = Duration(seconds: 15);

  static Future<EmailResult> send({
    required String to,
    required String name,
    required String surname,
    required String email,
    required String message,
  }) async {
    try {
      final endpoint = _getEndpointForRecipient(to);
      final uri = Uri.parse('$_baseUrl/$endpoint');

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nom': '$name $surname',
          'email': email,
          'message': message,
        }),
      ).timeout(_timeoutDuration);

      if (response.statusCode == 200) {
        return EmailResult.success();
      } else {
        final errorData = jsonDecode(response.body);
        return EmailResult.error(
          statusCode: response.statusCode,
          message: errorData['error'] ?? 'Erreur inconnue',
          details: errorData['details'] ?? response.body,
        );
      }
    } on http.ClientException catch (e) {
      return EmailResult.error(
        message: 'Erreur de connexion',
        details: e.message,
      );
    } on TimeoutException {
      return EmailResult.error(
        message: 'Temps d\'attente dépassé',
        details: 'La requête a pris trop de temps',
      );
    } catch (e) {
      return EmailResult.error(
        message: 'Erreur inattendue',
        details: e.toString(),
      );
    }
  }

  static String _getEndpointForRecipient(String email) {
    switch (email) {
      case 'lapetitefeecrochette@gmail.com':
        return 'sendToCrochette';
      case 'lespetitescreasdalexia@gmail.com':
        return 'sendToCreas';
      default:
        throw ArgumentError('Destinataire email non reconnu');
    }
  }
}

class EmailResult {
  final bool success;
  final int? statusCode;
  final String message;
  final String? details;

  EmailResult._({
    required this.success,
    this.statusCode,
    required this.message,
    this.details,
  });

  factory EmailResult.success() => EmailResult._(
    success: true,
    message: 'Email envoyé avec succès',
  );

  factory EmailResult.error({
    int? statusCode,
    required String message,
    String? details,
  }) => EmailResult._(
    success: false,
    statusCode: statusCode,
    message: message,
    details: details,
  );

  @override
  String toString() => 'EmailResult: $message'
      '${details != null ? ' ($details)' : ''}'
      '${statusCode != null ? ' [Code: $statusCode]' : ''}';
}