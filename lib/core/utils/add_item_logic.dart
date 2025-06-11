import 'dart:typed_data';
import 'dart:js_interop';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/web_utils.dart';

abstract class AddItemLogic<T> with ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

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
    return _selectedFileBytes != null &&
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty;
  }

  /// 👇 Fonction que tu dois implémenter dans la classe enfant
  Future<void> saveItem(T item);

  /// 👇 Construction de l'objet à implémenter dans la classe enfant
  T buildItem(String imageUrl, String id);

  /// 👇 Fonction d'enregistrement avec redirection
  Future<void> addItem(BuildContext context, Future<String> Function(Uint8List bytes, String id) uploadFile) async {
    if (!isValidInput()) return;

    try {
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      final imageUrl = await uploadFile(_selectedFileBytes!, id);
      final item = buildItem(imageUrl, id);

      await saveItem(item);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Création ajoutée avec succès')),
      );

      context.go('/account');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
