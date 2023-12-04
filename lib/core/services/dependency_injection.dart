import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/check_email_cubit/check_email_cubit.dart';
import '../../controllers/effect_medicines_cubit/factory_medicines_cubit.dart';
import '../../controllers/factory_medicines_cubit/effect_medicines_cubit.dart';
import '../../controllers/home_cubit/home_cubit.dart';
import '../../controllers/local_controller.dart';
import '../../controllers/login_cubit/login_cubit.dart';
import '../../controllers/medication_details_cubit/medication_details_cubit.dart';
import '../../controllers/register_cubit/register_cubit.dart';
import '../../controllers/reset_password_cubit/reset_password_cubit.dart';
import '../../controllers/search_cubit/search_cubit.dart';
import '../../controllers/verify_code_cubit/verify_code_cubit.dart';
import '../../data/remote/auth_data.dart';
import '../../my_bloc_observer.dart';
import '../class/crud.dart';

class AppInjection {
  AppInjection._();

  static final getIt = GetIt.instance;

  // static GetIt get getIt => _getIt;

  static Future<void> initial() async {
    // storage
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);

    // start
    getIt.registerLazySingleton(() => LocaleController());
    getIt.registerLazySingleton(() => MyBlocObserver());

    // data
    getIt.registerLazySingleton(() => Crud());
    getIt.registerLazySingleton(() => AuthRemoteData());

    /// controllers
    // auth
    getIt.registerFactory(() => RegisterCubit());
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => CheckEmailCubit());
    getIt.registerFactory(() => ResetPasswordCubit());
    getIt.registerFactory(() => VerifyCodeCubit());

    // home
    getIt.registerLazySingleton(() => HomeCubit());

    // medication details
    getIt.registerFactory(() => MedicationDetailsCubit());

    // search
    getIt.registerFactory(() => SearchCubit());

    // effect medicines
    getIt.registerFactory(() => EffectMedicinesCubit());

    // factory Medicines
    getIt.registerFactory(() => FactoryMedicinesCubit());
  }
}
