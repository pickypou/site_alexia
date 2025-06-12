import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_list_event.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_list_state.dart';
import 'package:les_petite_creations_d_alexia/core/base/generic_list_bloc.dart';
import 'package:les_petite_creations_d_alexia/data/dto/couture_dto.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/couture_interactor.dart';

import '../../../core/base/base_action_state.dart';
import '../../../core/base/generic_action_bloc.dart';
import '../../../core/di/di.dart';

class DeleteCouture extends StatelessWidget {
  const DeleteCouture({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      GenericActionBloc<CoutureDto>,
      BaseActionState<CoutureDto>
    >(
      listener: (context, state) {
        if (state is ActionSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Supprimé avec succès")),
          );
          // Optionnel : recharger la liste si besoin
          context.read<GenericListBloc<CoutureDto>>().add(LoadEvent());
        } else if (state is ActionFailureState<CoutureDto>) {
          final errorMessage = state.message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("❌ Erreur : ${state.message}")),
          );
        }
      },
      child: BlocBuilder<
        GenericListBloc<CoutureDto>,
        BaseListState<CoutureDto>
      >(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ErrorState<CoutureDto>) {
            return Center(child: Text(state.message));
          } else if (state is LoadState<CoutureDto>) {
            final coutures = state.items;
            if (coutures.isEmpty) {
              return const Center(child: Text("Aucune création trouvée."));
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = (constraints.maxWidth / 4.5).clamp(
                  200.0,
                  400.0,
                );
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                        child: Text(
                          "Je suppreme ma création",
                          style: titleStyleMedium(context),
                        ),
                      ),
                      const SizedBox(height: 75),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children:
                            coutures.map((dto) {
                              return SizedBox(
                                width: cardWidth,
                                child: Card(
                                  color: theme.colorScheme.error,
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.network(
                                            dto.imageUrl,
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (_, __, ___) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          dto.title,
                                          style: textStyleText(context),
                                        ),
                                        Text(dto.id,
                                            style: textStyleText(context)),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            debugPrint(
                                              'Suppression demandée pour id: "${dto.id}"',
                                            );
                                            if (dto.id.isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Erreur: ID vide, suppression annulée",
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                            _handleDelete(context, dto.id);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _handleDelete(BuildContext context, String id) async {
    final confirm = await _confirmDelete(context);
    final interactor = getIt<CoutureInteractor>();
    if (confirm) {
      try {
        await interactor.delete(id);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Supprimé avec succès")));
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur: ${e.toString()}")));
      }
    }
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Confirmer'),
                content: const Text('Supprimer cet élément?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Annuler'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Supprimer'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
