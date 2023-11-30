import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.search.tr,
        onTapBack: () => Navigator.pop(context),
      ).build(),
    );
  }
}
