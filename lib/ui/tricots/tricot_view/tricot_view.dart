import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_appbar.dart';
import 'package:les_petite_creations_d_alexia/ui/common/footer.dart';
import 'package:les_petite_creations_d_alexia/ui/tricots/tricot_view/tricot_list.dart';

class TricotView extends StatelessWidget {
  const TricotView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      drawer: size.width <= 745 ? CustomDrawer() : null,
      body:

      Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Expanded(child: TricotList()), // utiliser ici la liste liée au bloc
          Footer(),
        ],
      ),
    );
  }
}
