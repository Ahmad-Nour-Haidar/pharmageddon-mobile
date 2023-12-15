import '../constant/app_strings.dart';
import '../constant/app_svg.dart';

enum ScreenShow {
  medications(
    titleScreen: AppStrings.home,
    pathIcon: AppSvg.all,
  ),
  discount(
    titleScreen: AppStrings.discounts,
    pathIcon: AppSvg.percentage,
  ),
  manufacturer(
    titleScreen: AppStrings.manufacturers,
    pathIcon: AppSvg.text,
  ),
  effect(
    titleScreen: AppStrings.pharmacologicalEffect,
    pathIcon: AppSvg.chemistry,
  );

  final String titleScreen;
  final String pathIcon;

  const ScreenShow({required this.titleScreen, required this.pathIcon});
}
