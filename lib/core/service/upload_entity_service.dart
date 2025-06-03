import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadEntityService {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  UploadEntityService({
    required this.firestore,
    required this.storage,
  });

  Future<void> uploadEntity({
    required String collectionName,
    required String title,
    required String description,
    required String price,
    required Uint8List fileBytes,
    String? id,
  }) async {
    final String docId = id ?? firestore.collection(collectionName).doc().id;
    final String filePath = '$collectionName/$docId.jpg';

    final ref = storage.ref(filePath);
    await ref.putData(fileBytes);
    final imageUrl = await ref.getDownloadURL();

    final data = {
      'id': docId,
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };

    await firestore.collection(collectionName).doc(docId).set(data);
  }
}
