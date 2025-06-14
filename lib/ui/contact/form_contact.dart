import 'package:flutter/material.dart';
import '../../core/service/email_service.dart';
import '../../theme.dart';
import '../common/custom_buttom.dart';

class FormContact extends StatefulWidget {
  const FormContact({super.key});

  @override
  FormContactState createState() => FormContactState();
}

class FormContactState extends State<FormContact> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;
  String? _selectedRecipient;

  Future<void> _sendEmail() async {
    // Correction 1: Validation explicite du formulaire
    final isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid == false || _selectedRecipient == null) {
      return;
    }

    setState(() => _isSending = true);

    try {
      final success = await EmailService.send(
        to: _selectedRecipient!,
        name: _nameController.text,
        surname: _surnameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      // Correction 2: Vérification explicite de mounted
      if (mounted == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success == true
                  ? '✅ Message envoyé !'
                  : '❌ Échec de l\'envoi',
            ),
            backgroundColor: success == true ? Colors.green : Colors.red,
          ),
        );

        // Correction 3: Réinitialisation conditionnelle
        if (success == true) {
          _formKey.currentState?.reset();
        }
      }
    } finally {
      // Correction 4: Vérification de mounted avant setState
      if (mounted == true) {
        setState(() => _isSending = false);
      }
    }
  }

  String _getRecipientName(String email) {
    return email == 'lapetitefeecrochette@gmail.com'
        ? "La Petite Fée"
        : "Les Créas";
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.error,
              border: Border.all(color: theme.colorScheme.primary, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _buildTextField(controller: _nameController, label: 'Nom'),
                    const SizedBox(height: 10),
                    _buildTextField(controller: _surnameController, label: 'Prénom'),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _messageController,
                      label: 'Message',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 20),
                    _buildRecipientButtons(),
                    const SizedBox(height: 20),
                    CustomButton(
                      onPressed: _isSending || _selectedRecipient == null ? null : _sendEmail,
                      label: _isSending ? 'Envoi en cours...' : 'Envoyer',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildRecipientButton(
            email: 'lapetitefeecrochette@gmail.com',
            label: 'La Petite Fée',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildRecipientButton(
            email: 'lespetitescreasdalexia@gmail.com',
            label: 'Les Créas',
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientButton({
    required String email,
    required String label,
  }) {
    final isSelected = _selectedRecipient == email;
    return ElevatedButton(
      onPressed: _isSending ? null : () => setState(() => _selectedRecipient = email),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? theme.colorScheme.secondary : theme.colorScheme.onPrimary,
          width: 3.0,
        ),
        backgroundColor: theme.colorScheme.secondary,
        foregroundColor: theme.colorScheme.secondary,
      ),
      child: Text(
        label,
        style: TextStyle(color: theme.colorScheme.primary),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Veuillez entrer votre email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Email invalide';
    return null;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: theme.colorScheme.primary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: theme.colorScheme.primary),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre $label';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}