import 'package:get_it/get_it.dart';
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
import '../../controllers/notification_cubit/notification_cubit.dart';
import '../../controllers/order_cubit/order_cubit.dart';
import '../../controllers/order_details_cubit/order_details_cubit.dart';
import '../../controllers/profile_cubit/profile_cubit.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../controllers/search_cubit/search_cubit.dart';
import '../../data/crud_dio.dart';
import '../../data/local/app_hive.dart';
import '../../data/local/cart_quantity_data.dart';
import '../../data/remote/app_firebase.dart';
import '../../data/remote/auth_data.dart';
import '../../data/remote/effect_medicines_data.dart';
import '../../data/remote/factory_medicines_data.dart';
import '../../data/remote/favorite_data.dart';
import '../../data/remote/home_data.dart';
import '../../data/remote/order_data.dart';
import '../../data/remote/reports_data.dart';
import '../../data/remote/search_data.dart';
import '../../my_bloc_observer.dart';
import '../../view/widgets/app_widget.dart';
import '../class/image_helper.dart';
import '../functions/functions.dart';

abstract class AppInjection {
  static final getIt = GetIt.instance;

  static Future<void> initial() async {
    /// storage
    final appHive = await AppHive.getInstance();
    getIt.registerLazySingleton(() => appHive);
    initialUser();

    /// start
    final appFirebase = await AppFirebase.getInstance();
    getIt.registerLazySingleton(() => appFirebase);
    final localeController = await LocaleController.getInstance();
    getIt.registerLazySingleton(() => localeController);
    getIt.registerLazySingleton(() => MyBlocObserver());

    /// data
    getIt.registerLazySingleton(() => CrudDio());
    getIt.registerLazySingleton(() => AuthRemoteData());
    getIt.registerLazySingleton(() => HomeRemoteData());
    getIt.registerLazySingleton(() => SearchRemoteData());
    getIt.registerLazySingleton(() => FavoriteRemoteData());
    getIt.registerLazySingleton(() => ManufacturerMedicinesRemoteData());
    getIt.registerLazySingleton(() => EffectMedicinesRemoteData());
    getIt.registerLazySingleton(() => OrderRemoteData());
    getIt.registerLazySingleton(() => ReportsRemoteData());
    getIt.registerLazySingleton(() => ImageHelper());
    final cartQuantityData = await CartQuantityData.getInstance();
    getIt.registerLazySingleton(() => cartQuantityData);

    /// controllers
    // auth
    getIt.registerFactory(() => RegisterCubit());
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => CheckEmailCubit());
    getIt.registerFactory(() => ResetPasswordCubit());
    getIt.registerFactory(() => VerifyCodeCubit());
    getIt.registerFactory(() => ProfileCubit());

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

    // order details
    getIt.registerFactory(() => OrderDetailsCubit());

    /// singleton
    // favorite
    getIt.registerLazySingleton(() => FavoriteCubit());

    // home
    getIt.registerLazySingleton(() => HomeCubit());

    // order
    getIt.registerLazySingleton(() => OrderCubit());

    // notification
    getIt.registerLazySingleton(() => NotificationCubit());

    // widgets
    getIt.registerLazySingleton(() => AppWidget());
  }
}
