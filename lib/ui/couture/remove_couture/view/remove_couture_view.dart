import 'package:flutter/material.dart';
import 'package:les_petite_creations_d_alexia/ui/couture/remove_couture/view/remove_couture_list.dart';

import '../../../common/custom_appbar_admin.dart';



class RemoveCoutureView  extends StatelessWidget {
  const RemoveCoutureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBarAdmin(title: ''),
      drawer:
      MediaQuery.of(context).size.width <= 750
          ? const CustomDrawerAdmin()
          : null,
      body: RemoveCoutureList(),
    );
  }
}
