import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path:'gregdescamps46@gmail.com',
        query: 'subject=Demande de contact&body=Nom: ${_nameController.text}\n'
            'Prénom: ${_surnameController.text}\n'
            'Email: ${_emailController.text}\n\n'
            'Message: ${_messageController.text}',
      );

      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else if (mounted) {  // Vérifie si le widget est toujours monté
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Impossible d\'ouvrir l\'application de messagerie.'
            ),
          ),
        );
      }
    }
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
              border: Border.all(color: theme.colorScheme.secondary, width: 2),
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
                    _buildTextField(
                        controller: _nameController,
                        label: 'Nom'
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _surnameController,
                      label: 'Prénom',
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      controller: _messageController,
                      label: 'Message',
                      maxLines: 5,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                        onPressed: _sendEmail,
                        label: 'envoyer'

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
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.secondary, width: 2),
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