
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_appbar.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_appbar_admin.dart';
import 'package:les_petite_creations_d_alexia/ui/common/footer.dart';

import 'delete_couture.dart';

class DeleteCoutureView extends StatelessWidget {
  const DeleteCoutureView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar:  CustomAppBarAdmin(title: ''),
      drawer: size.width <= 745 ? CustomDrawerAdmin() : null,
      body:

      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: DeleteCouture()), // utiliser ici la liste liée au bloc
          const Footer(),
        ],
      ),
    );
  }
}

