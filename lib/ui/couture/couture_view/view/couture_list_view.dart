import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/common/product_card.dart';

import '../couture_bloc.dart';
import '../couture_state.dart';




class CoutureListView extends StatelessWidget {
  const CoutureListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoutureBloc, CoutureState>(
      builder: (context, state) {
        if (state is CoutureLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CoutureErrorState) {
          return Center(child: Text(state.message));
        } else if (state is CoutureLoadedState) {
          final coutures = state.coutureData;
          if (coutures.isEmpty) {
            return const Center(child: Text("Aucune création trouvée."));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth / 4.5).clamp(200.0, 400.0);
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                      child: Text("Nos réalisations couture", style: titleStyleMedium(context)),
                    ),
                    const SizedBox(height: 75),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: coutures.map((evt) {
                        return SizedBox(
                          width: cardWidth,
                          child: ProductCard(
                            imageUrl: evt.imageUrl,
                            title: evt.title,
                            description: evt.description,
                            price: evt.price,
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
    );
  }
}


