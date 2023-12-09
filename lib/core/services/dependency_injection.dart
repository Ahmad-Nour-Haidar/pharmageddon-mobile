import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth/check_email_cubit/check_email_cubit.dart';
import '../../controllers/auth/login_cubit/login_cubit.dart';
import '../../controllers/auth/register_cubit/register_cubit.dart';
import '../../controllers/auth/reset_password_cubit/reset_password_cubit.dart';
import '../../controllers/auth/verify_code_cubit/verify_code_cubit.dart';
import '../../controllers/cart_cubit/cart_cubit.dart';
import '../../controllers/effect_medicines_cubit/effect_medicines_cubit.dart';
import '../../controllers/favorite_cubit/favorite_cubit.dart';
import '../../controllers/home_cubit/home_cubit.dart';
import '../../controllers/local_controller.dart';
import '../../controllers/manufacturer_medicines_cubit/manufacturer_medicines_cubit.dart';
import '../../controllers/medication_details_cubit/medication_details_cubit.dart';
import '../../controllers/order_cubit/order_cubit.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../controllers/search_cubit/search_cubit.dart';
import '../../data/crud_dio.dart';
import '../../data/local/app_hive.dart';
import '../../data/local/cart_quantity_data.dart';
import '../../data/remote/auth_data.dart';
import '../../data/remote/cart_data.dart';
import '../../data/remote/effect_medicines_data.dart';
import '../../data/remote/factory_medicines_data.dart';
import '../../data/remote/favorite_data.dart';
import '../../data/remote/home_data.dart';
import '../../data/remote/order_data.dart';
import '../../data/remote/reports_data.dart';
import '../../data/remote/search_data.dart';
import '../../my_bloc_observer.dart';

class AppInjection {
  static final getIt = GetIt.instance;

  Future<void> initial() async {
    /// storage
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);
    final appHive = await AppHive.getInstance();
    getIt.registerLazySingleton(() => appHive);

    /// start
    final localeController = await LocaleController.getInstance();
    getIt.registerLazySingleton(() => localeController);
    getIt.registerLazySingleton(() => MyBlocObserver());

    /// data
    getIt.registerLazySingleton(() => Crud());
    getIt.registerLazySingleton(() => AuthRemoteData());
    getIt.registerLazySingleton(() => HomeRemoteData());
    getIt.registerLazySingleton(() => SearchRemoteData());
    getIt.registerLazySingleton(() => FavoriteRemoteData());
    getIt.registerLazySingleton(() => FactoryMedicinesRemoteData());
    getIt.registerLazySingleton(() => EffectMedicinesRemoteData());
    getIt.registerLazySingleton(() => OrderRemoteData());
    final cartQuantityData = await CartQuantityData.getInstance();
    getIt.registerLazySingleton(() => cartQuantityData);
    getIt.registerLazySingleton(() => CartRemoteData());
    getIt.registerLazySingleton(() => ReportsRemoteData());

    /// controllers
    // auth
    getIt.registerFactory(() => RegisterCubit());
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => CheckEmailCubit());
    getIt.registerFactory(() => ResetPasswordCubit());
    getIt.registerFactory(() => VerifyCodeCubit());

    // favorite => <singleton>
    getIt.registerLazySingleton(() => FavoriteCubit());

    // home => <singleton>
    getIt.registerLazySingleton(() => HomeCubit());

    // medication details
    getIt.registerFactory(() => MedicationDetailsCubit());

    // search
    getIt.registerFactory(() => SearchCubit());

    // effect medicines
    getIt.registerFactory(() => EffectMedicinesCubit());

    // factory Medicines
    getIt.registerFactory(() => ManufacturerMedicinesCubit());

    // cart
    getIt.registerFactory(() => CartCubit());

    // reports
    getIt.registerFactory(() => ReportsCubit());

    // order
    getIt.registerFactory(() => OrderCubit());
  }
}
