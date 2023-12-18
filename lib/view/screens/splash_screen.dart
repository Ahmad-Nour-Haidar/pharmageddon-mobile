import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/constant/app_svg.dart';
import '../../core/resources/app_text_theme.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  Future<void> nextScreen() async {
    var initialRoute = AppRoute.register;
    if (AppLocalData.user != null && AppLocalData.user!.authorization != null) {
      initialRoute = AppRoute.home;
    }
    Future.delayed(const Duration(seconds: 3), () {
      pushNamedAndRemoveUntil(initialRoute, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.cardColor,
        child: FadeIn(
          duration: const Duration(milliseconds: 1500),
          delay: const Duration(milliseconds: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppSvg.logo,
                  width: 150,
                  height: 150,
                ),
              ),
              const Gap(20),
              const Center(
                child: Text(
                  'Pharmageddon',
                  style: AppTextStyle.f24w600SecondColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
