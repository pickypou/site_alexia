import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_buttom.dart';

import '../../../core/base/base_repository.dart';
import '../../../core/di/di.dart';
import '../../../data/dto/couture_dto.dart';
import '../../common/custom_text_field.dart';

class AddCouture extends StatefulWidget {
  const AddCouture({super.key});

  @override
  State<AddCouture> createState() => _AddCoutureState();
}

class _AddCoutureState extends State<AddCouture> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final ValueNotifier<Uint8List?> selectedFile = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Text("J'ajoute ma création", style: titleStyleMedium(context),
           textAlign: TextAlign.center,

          ),
          const SizedBox(height: 55,),
          ValueListenableBuilder<Uint8List?>(
            valueListenable: selectedFile,
            builder: (ctx, bytes, _) {
              if (bytes == null) return const SizedBox.shrink();
              return Image.memory(bytes , height: 150, width: 150);
            },
          ),
          CustomTextField(controller: titleController, labelText: 'Titre', maxLines: 1),
          const SizedBox(height: 35,),
          CustomTextField(controller: descriptionController, labelText: 'Description', maxLines: 3),
          const SizedBox(height: 35,),
          CustomTextField(controller: priceController, labelText: 'Prix', maxLines: 1),
          const SizedBox(height: 35,),
          CustomButton(
            onPressed: () async {
              final result = await FilePicker.platform.pickFiles(withData: true);
              if (result?.files.first.bytes != null) {
                selectedFile.value = result!.files.first.bytes;
              }
            },
            label: 'Choisir image',
          ),
         const SizedBox(height: 35,),

          CustomButton(
            label: 'Ajouter',
            onPressed: () async {
              final bytes = selectedFile.value;
              final title = titleController.text.trim();
              final desc = descriptionController.text.trim();
              final price = priceController.text.trim();

              if (bytes == null || title.isEmpty || desc.isEmpty || price.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Remplis tous les champs et choisis une image.")),
                );
                return;
              }

              final id = DateTime.now().millisecondsSinceEpoch.toString();
              try {
                // 🚀 upload l'image
                final ref = FirebaseStorage.instance
                    .ref('couture/$id.jpg');
                final uploadTask = await ref.putData(
                  bytes,
                  SettableMetadata(contentType: 'image/jpeg'),
                ); // putData fonctionne en web :contentReference[oaicite:1]{index=1}

                final imageUrl = await uploadTask.ref.getDownloadURL();

                // Crée le DTO
                final dto = CoutureDto(
                  id: id,
                  title: title,
                  description: desc,
                  price: price,
                  imageUrl: imageUrl,
                );

                // Sauvegarde via ton repo (injection via getIt ou params)
                await getIt<BaseRepository<CoutureDto>>().add(dto);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Création ajoutée avec succès !")),
                );
                context.go('/account');
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur : $e")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

}
