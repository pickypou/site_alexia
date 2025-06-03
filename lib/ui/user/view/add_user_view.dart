import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


import '../../../theme.dart';
import '../../common/custom_buttom.dart';
import '../../common/custom_text_field.dart';
import '../add_user_bloc.dart';
import '../add_user_event.dart';
import '../add_user_state.dart';

class AddUserView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  AddUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddUserBloc, AddUserState>(builder: (context, state) {
      if (state is SignUpLoadingState) {
        return const SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(),
        );
      } else if (state is SignUpErrorState) {
        return Text(state.error);
      } else {
        return _buildForm(context);
      }
    });
  }

  Widget _buildForm(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    if (size.width < 749) {
      return Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Je crée un compte',
                  style: titleStyleMedium(context),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomTextField(
                  labelText: 'Email',
                  maxLines: 1,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomTextField(
                  labelText: 'Mot de passe',
                  maxLines: 1,
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomTextField(
                  labelText: 'Prénom',
                  maxLines: 1,
                  controller: userNameController,
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomButton(
                    onPressed: () {
                      context.read<AddUserBloc>().add(AddUserSignUpEvent(
                          id: '',
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          userName: userNameController.text,
                          navigateToAccount: () =>
                              GoRouter.of(context).go('/account')));
                    },
                    label: 'Je valide mon compte')
              ],
            ),
          ));
    } else {
      return Scaffold(

          body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      'Je crée un compte',
                      style: titleStyleLarge(context),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomTextField(
                      labelText: 'Email',
                      maxLines: 1,
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomTextField(
                      labelText: 'Mot de passe',
                      maxLines: 1,
                      controller: passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomTextField(
                      labelText: 'Prénom',
                      maxLines: 1,
                      controller: userNameController,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                        onPressed: () {
                          context.read<AddUserBloc>().add(AddUserSignUpEvent(
                              id: '',
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              userName: userNameController.text,
                              navigateToAccount: () =>
                                  GoRouter.of(context).go('/account')));
                        },
                        label: 'Je valide mon compte'),
                  ],
                ),
              )));
    }
  }
}