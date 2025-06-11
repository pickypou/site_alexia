import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../theme.dart';
import '../../../common/custom_buttom.dart';
import '../../../common/custom_text_field.dart';
import '../user_login_bloc.dart';
import '../user_login_event.dart';
import '../user_login_state.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginBloc, UserLoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text("Erreur de connexion"),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            title: TextButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Accueil', style: textStyleTextAppBar(context),),
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.center,
                  child: Text('Connexion', style: titleStyleLarge(context)),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                  maxLines: 1,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  labelText: 'Mot de passe',
                  controller: passwordController,
                  obscureText: true,
                  maxLines: 1,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  label: 'Connexion',
                  onPressed: () {
                    context.read<UserLoginBloc>().add(
                      LoginWithEmailPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        navigateToAccount: () {
                          GoRouter.of(context).go('/account');
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
        );
      },
    );
  }
}
