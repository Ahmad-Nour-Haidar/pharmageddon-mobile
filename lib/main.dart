import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pharmageddon_mobile/controllers/favorite_cubit/favorite_cubit.dart';
import 'package:pharmageddon_mobile/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'controllers/local_controller.dart';
import 'controllers/order_cubit/order_cubit.dart';
import 'core/constant/app_constant.dart';
import 'core/functions/functions.dart';
import 'core/localization/translation.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  await AppInjection.initial();
  initialUser();

  Bloc.observer = AppInjection.getIt<MyBlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppInjection.getIt<HomeCubit>()..initial()),
        BlocProvider(create: (context) => AppInjection.getIt<FavoriteCubit>()),
        BlocProvider(create: (context) => AppInjection.getIt<OrderCubit>()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstant.isEnglish ? 'Pharmageddon' : 'فارماجيدون',
        locale: AppInjection.getIt<LocaleController>().locale,
        translations: MyTranslation(),
        theme: themeData(),
        routes: routes,
        initialRoute: AppRoute.splash,
      ),
    );
  }
}
