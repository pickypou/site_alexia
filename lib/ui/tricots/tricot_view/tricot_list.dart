import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:les_petite_creations_d_alexia/core/base/base_list_state.dart';
import 'package:les_petite_creations_d_alexia/core/base/generic_list_bloc.dart';
import 'package:les_petite_creations_d_alexia/data/dto/tricot_dto.dart';
import 'package:les_petite_creations_d_alexia/theme.dart';
import 'package:les_petite_creations_d_alexia/ui/common/product_card.dart';


class TricotList extends StatelessWidget {
  const TricotList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericListBloc<TricotDto>, BaseListState<TricotDto>>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState<TricotDto>) {
          return Center(child: Text(state.message));
        } else if (state is LoadState<TricotDto>) {
          final tricot = state.items;
          if (tricot.isEmpty) {
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
                      child: Text("Nos réalisations au crochet", style: titleStyleMedium(context)),
                    ),
                    const SizedBox(height: 75),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: tricot.map((dto) {
                        return SizedBox(
                          width: cardWidth,
                          child: ProductCard(
                            imageUrl: dto.imageUrl,
                            title: dto.title,
                            description: dto.description,
                            price: dto.price,
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

