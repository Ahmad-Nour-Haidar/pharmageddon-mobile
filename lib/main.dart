import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmageddon_mobile/controllers/favorite_cubit/favorite_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'controllers/local_controller.dart';
import 'core/constant/app_local_data.dart';
import 'core/functions/functions.dart';
import 'core/localization/translation.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await AppInjection().initial();
  initialUser();

  Bloc.observer = AppInjection.getIt<MyBlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    final controller = AppInjection.getIt<LocaleController>();
    var initialRoute = AppRoute.register;
    if (AppLocalData.user != null && AppLocalData.user!.authorization != null) {
      initialRoute = AppRoute.home;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppInjection.getIt<HomeCubit>()..initial(),
        ),
        BlocProvider(
          create: (context) => AppInjection.getIt<FavoriteCubit>(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pharmageddon',
        locale: controller.locale,
        translations: MyTranslation(),
        theme: themeData(),
        routes: routes,
        initialRoute: initialRoute,
      ),
    );
  }
}
