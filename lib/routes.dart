import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/view/screens/auth/check_email_phone_screen.dart';
import 'package:pharmageddon_mobile/view/screens/home_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/login_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/register_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/reset_password_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/veryify_code_screen.dart';
import 'package:pharmageddon_mobile/view/screens/medicine_details_screen.dart';
import 'package:pharmageddon_mobile/view/screens/search_screen.dart';

abstract class AppRoute {
  // auth
  static const login = '/login';
  static const register = '/register';
  static const verifyCode = '/verify-code';
  static const checkEmail = '/check-email';
  static const resetPassword = '/reset-password';

  // home
  static const home = '/home';
  static const medicineDetails = '/medicine-details';

  // search
  static const search = '/search';
}

final Map<String, Widget Function(BuildContext)> routes = {
// auth
  AppRoute.register: (_) => const RegisterScreen(),
  AppRoute.login: (_) => const LoginScreen(),
  AppRoute.verifyCode: (_) => const VerifyCodeScreen(),
  AppRoute.checkEmail: (_) => const CheckEmailScreen(),
  AppRoute.resetPassword: (_) => const ResetPasswordScreen(),

// home
  AppRoute.home: (_) => const HomeScreen(),
  AppRoute.medicineDetails: (_) => const MedicationDetailsScreen(),

  // search
  AppRoute.search: (_) => const SearchScreen(),
};
