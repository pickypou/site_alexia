import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:les_petite_creations_d_alexia/core/di/di.dart';
import 'package:les_petite_creations_d_alexia/domain/use_case/fetch_couture_data_usecase.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/remove_couture_interactor.dart';

import '../../../../data/repository/couture_repository.dart';

class RemoveCoutureList extends StatelessWidget {
  final auth = GetIt.instance<FirebaseAuth>();
   RemoveCoutureList({super.key});

  @override
  Widget build(BuildContext context) {
    final interactor = RemoveCoutureInteractor(
        getIt<FetchCoutureDataUseCase>(),
        getIt<CoutureRepository>(),
      getIt<FirebaseFirestore>(),
      getIt<FirebaseStorage>()

    );
    return Scaffold(


      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('couture').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            if(snapshot.hasError) {
              return Center(child: Text("Erreur : ${snapshot.error}"),);
            }
            if( !snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Aucun objet trouvé."),);
            }
            final coutures = snapshot.data!.docs;

            return Padding(
                padding: const EdgeInsets.all(0.8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Je supprime un objet couture", style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: coutures.map((doc) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width* 0.45,
                        child: Card(
                          elevation: 0,
                          color: theme.colorScheme.error,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                              color: theme.colorScheme.primary,
                              width: 2.0
                            )
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                          ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              doc['imageUrl'] ?? doc['fileUrl'],
                              height: 80.0,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                              Text(doc['title'],
                              style: textStyleText(context),
                              textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0,),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () async {
                                  final confirm = await _confirmDelete(context);
                                  if(confirm) {
                                    try {
                                      await interactor.removeCouture(doc.id, doc['imageUrl'] ?? doc['fileUrl']);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                "Objet supprimé avec succés"
                                              )
                                          )
                                      );
                                    }catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Erreur : $e'))
                                      );
                                    }
                                  }
                                  },
                                  )

                            ],
                          ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            );
          }),

    );
  }
  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.onError, // ✅ Uniformise avec les cartes
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: theme.colorScheme.primary, // ✅ Ajoute une bordure cohérente
              width: 2.0,
            ),
          ),
          title: Text('Confirmer la suppression', style: titleStyleMedium(context)),
          content:  Text('Voulez-vous vraiment supprimer ?',style: textStyleText(context),),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error, // ✅ Bouton rouge pour la suppression
                foregroundColor: theme.colorScheme.onError, // ✅ Texte contrasté
              ),
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    ) ?? false;
  }

}
