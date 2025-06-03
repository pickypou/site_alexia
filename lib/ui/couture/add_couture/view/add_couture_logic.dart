import 'dart:js_interop';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';

import '../../../../core/utils/web_utils.dart';
import '../../../../theme.dart';
import '../couture_interactor.dart';
import 'package:les_petite_creations_d_alexia/domain/entity/couture.dart';

class AddCoutureLogic with ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final CoutureInteractor _interactor = getIt<CoutureInteractor>();
  Uint8List? _selectedFileBytes;
  String? _fileName;
  String? _fileType;

  Uint8List? get selectedFileBytes => _selectedFileBytes;
  String? get fileName => _fileName;
  String? get fileType => _fileType;

  String _getFileType(String extension) {
    final imageExtensions = ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'];
    if (imageExtensions.contains(extension)) return 'image';
    return 'unknown';
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'jpeg'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        _selectedFileBytes = result.files.first.bytes;
        _fileName = result.files.first.name;
        final extension = result.files.first.extension?.toLowerCase() ?? '';
        _fileType = _getFileType(extension);
        notifyListeners();
      } else {
        debugPrint("Aucun fichier sélectionné.");
      }
    } catch (e) {
      debugPrint("Erreur lors de la sélection du fichier : $e");
    }
  }

  Widget buildFilePreview(BuildContext context) {
    if (_selectedFileBytes == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        final jsArray = <JSAny?>[_selectedFileBytes!.toJS].toJS;
        final blob = createBlob(jsArray, BlobPropertyBag(type: 'image/jpeg'));
        final url = createObjectUrl(blob);
        open(url, '_blank');

      },
      child: Image.memory(
        _selectedFileBytes!,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }


  bool isValidInput() {
    return _selectedFileBytes != null
        && titleController.text.isNotEmpty
    && descriptionController.text.isNotEmpty
    && priceController.text.isNotEmpty;
  }

  Future<void> addCouture(BuildContext context) async {

    if (isValidInput()) {
      try {
        final id = DateTime.now().millisecondsSinceEpoch.toString();

        final imageUrl = await _interactor.uploadCoutureFile(
          _selectedFileBytes!,
          id,
        );

        final couture = Couture(
          id: id,
          title: titleController.text,
          imageUrl: imageUrl,
          description: descriptionController.text,
          price: priceController.text,
        );

        await _interactor.addCouture(couture);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Événement ajouté avec succès')),
        );

        GoRouter.of(context).go('/account');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e', style: textStyleText(context))),
        );
      }
    }
  }
}
