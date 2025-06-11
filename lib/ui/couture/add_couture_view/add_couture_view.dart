
import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_appbar.dart';
import 'package:les_petite_creations_d_alexia/ui/common/custom_appbar_admin.dart';
import 'package:les_petite_creations_d_alexia/ui/common/footer.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/add_couture_view/add_couture.dart';

class AddCoutureView extends StatelessWidget {
  const AddCoutureView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar:  CustomAppBarAdmin(title: ''),
      drawer: size.width <= 745 ? CustomDrawerAdmin() : null,
      body:

      Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Expanded(child: AddCouture()), // utiliser ici la liste liée au bloc
          Footer(),
        ],
      ),
    );
  }
}

