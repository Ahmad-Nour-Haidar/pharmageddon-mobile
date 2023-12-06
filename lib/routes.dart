import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/view/screens/auth/check_email_phone_screen.dart';
import 'package:pharmageddon_mobile/view/screens/cart_screen.dart';
import 'package:pharmageddon_mobile/view/screens/manufacturer_medicines_screen.dart';
import 'package:pharmageddon_mobile/view/screens/favorite_screen.dart';
import 'package:pharmageddon_mobile/view/screens/home_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/login_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/register_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/reset_password_screen.dart';
import 'package:pharmageddon_mobile/view/screens/auth/verify_code_screen.dart';
import 'package:pharmageddon_mobile/view/screens/medicine_details_screen.dart';
import 'package:pharmageddon_mobile/view/screens/effect_medicines_screen.dart';
import 'package:pharmageddon_mobile/view/screens/orders_screen.dart';
import 'package:pharmageddon_mobile/view/screens/profile_screen.dart';
import 'package:pharmageddon_mobile/view/screens/reports_screen.dart';
import 'package:pharmageddon_mobile/view/screens/search_screen.dart';

abstract class AppRoute {
  // auth
  static const login = '/login';
  static const register = '/register';
  static const verifyCode = '/verify-code';
  static const checkEmail = '/check-email';
  static const resetPassword = '/reset-password';
  static const profile = '/profile';

  // home
  static const home = '/home';
  static const medicineDetails = '/medicine-details';
  static const factoryMedicinesScreen = '/factory-medicines-screen';
  static const effectMedicinesScreen = '/effect-medicines-screen';

  // search
  static const search = '/search';

  // cart
  static const cart = '/cart';

  // orders
  static const orders = '/orders';

  // favorites
  static const favorites = '/favorites';

  // reports
  static const reports = '/reports';

  // logout
  static const logout = '/logout';
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
  AppRoute.factoryMedicinesScreen: (_) => const ManufacturerMedicinesScreen(),
  AppRoute.effectMedicinesScreen: (_) => const EffectMedicinesScreen(),

  // search
  AppRoute.search: (_) => const SearchScreen(),
  AppRoute.profile: (_) => const ProfileScreen(),
  AppRoute.cart: (_) => const CartScreen(),
  AppRoute.orders: (_) => const OrdersScreen(),
  AppRoute.favorites: (_) => const FavoriteScreen(),
  AppRoute.reports: (_) => const ReportsScreen(),
};
