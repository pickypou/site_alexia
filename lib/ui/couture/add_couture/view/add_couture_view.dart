import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_buttom.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_text_field.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture/view/add_couture_logic.dart';

import '../../../../theme.dart';
import '../../../common/custom_appbar_admin.dart';

class AddCoutureView extends StatefulWidget {
  const AddCoutureView({super.key});

  @override
  State<AddCoutureView> createState() => _AddCoutureViewState();
}

class _AddCoutureViewState extends State<AddCoutureView> {
  final AddCoutureLogic logic = AddCoutureLogic();

  @override
  void dispose() {
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.instance<FirebaseAuth>();

    return Scaffold(
      appBar:  CustomAppBarAdmin(title: ''),
      drawer:
      MediaQuery.of(context).size.width <= 750
          ? const CustomDrawerAdmin()
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 85),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Ajouté ma création",
                  style: titleStyleMedium(context),
                ),
              ),
              const SizedBox(height: 55),
              CustomTextField(
                controller: logic.titleController,
                labelText: "Le nom de ma création",
                maxLines: 1,
              ),
              const SizedBox(height: 35),
              CustomTextField(
                controller: logic.descriptionController,
                labelText: "La description de ma création",
                maxLines: 1,
              ),
              const SizedBox(height: 35),
              CustomTextField(
                controller: logic.priceController,
                labelText: "Le prix de ma création",
                maxLines: 1,
              ),
              const SizedBox(height: 35),
              CustomButton(
                label: "Je choisi mon image",
                onPressed: logic.pickFile,
              ),

              const SizedBox(height: 20),
              ListenableBuilder(
                listenable: logic,
                builder: (context, _) {
                  if (logic.selectedFileBytes != null) {
                    return logic.buildFilePreview(context);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 35),
              ListenableBuilder(
                listenable: logic,
                builder: (context, _) {
                  return CustomButton(
                    onPressed:
                    logic.isValidInput()
                        ? () => logic.addCouture(context)
                        : null,
                    label: "Ajouter ma création",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}