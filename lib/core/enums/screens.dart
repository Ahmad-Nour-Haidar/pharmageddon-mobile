import '../constant/app_text.dart';
import '../constant/app_svg.dart';

enum ScreenShow {
  medications(
    titleScreen: AppText.home,
    pathIcon: AppSvg.all,
  ),
  discount(
    titleScreen: AppText.discounts,
    pathIcon: AppSvg.percentage,
  ),
  manufacturer(
    titleScreen: AppText.manufacturers,
    pathIcon: AppSvg.text,
  ),
  effect(
    titleScreen: AppText.pharmacologicalEffect,
    pathIcon: AppSvg.chemistry,
  ),
  hasBeenSent(
    titleScreen: AppText.hasBeenSent,
    pathIcon: AppSvg.sent,
  ),
  received(
    titleScreen: AppText.received,
    pathIcon: AppSvg.boxCircleCheck,
  ),
  preparing(
    titleScreen: AppText.preparing,
    pathIcon: AppSvg.boxOpen,
  );

  final String titleScreen;
  final String pathIcon;

  const ScreenShow({required this.titleScreen, required this.pathIcon});
}
