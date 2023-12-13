class AppLink {
  AppLink._();

  // http://127.0.0.1/api/auth/register

  // static const _host = '10.0.2.2:8000';

  // static const _host = 'localhost:8000';
  //
  // static const _host = '192.168.43.76:8000';
  //
  static const _host = 'pharmageddon-myproject.000webhostapp.com';

  //
  // static const _host = '192.168.229.48:8000';

  // static const _host = '192.168.108.48:8000';

  static const _serverApi = 'http://$_host/api';

  static const _serverUpload = 'http://$_host';

  static const _serverImage = '$_serverUpload/images';

  // http://10.0.2.2:8000/images/items/image.png
  // http://127.0.0.1/images/users/image.png
  // http://127.0.0.1/images/categories/image.png

  // auth
  // http://10.0.2.2:8000/api/auth/register
  static const register = '$_serverApi/auth/register';
  static const sendVerificationCode = '$_serverApi/auth/send_verification_code';
  static const login = '$_serverApi/auth/login';
  static const checkVerifyCode = '$_serverApi/auth/check_verification_code';
  static const checkEmail = '$_serverApi/auth/check_user_if_exists';
  static const resetPassword = '$_serverApi/auth/reset_password';
  static const profile = '$_serverApi/auth/get_user_profile';
  static const logout = '$_serverApi/auth/logout';
  static const edit = '$_serverApi/auth/update_user_profile';
  static const userImage = '$_serverImage/users';

  // medicine
  static const getAllMedicine = '$_serverApi/medicine/get_all';
  static const medicineImage = '$_serverImage/medicines';

  // manufacturer
  static const getAllManufacturer = '$_serverApi/manufacturer/get_all_c';
  static const getAllMedicinesOfManufacturer = '$_serverApi/class/manufacturer';

  // effect categories
  static const categoriesImage = '$_serverImage/effect_categories';
  static const getAllEffectCategories = '$_serverApi/effect_category/get_all_c';
  static const getAllMedicinesOfEffect = '$_serverApi/class/effect_category';

  // favorite
  static const favoriteGetAll = '$_serverApi/favourite_medicine/get_all';
  static const favorite = '$_serverApi/favourite_medicine/create';
  static const unFavorite = '$_serverApi/favourite_medicine/delete';

  // search
  static const search = '$_serverApi/search';

  // order
  static const order = '$_serverApi/order/create';
  static const getAll = '$_serverApi/order/get_all';
  static const getAllPreparing = '$_serverApi/order/get_all_preparing';
  static const getAllSent = '$_serverApi/order/get_all_sent';
  static const getAllReceived = '$_serverApi/order/get_all_received';
  static const getOrderDetails = '$_serverApi/order/get';
  static const delete = '$_serverApi/order/delete';

  // report
  static const report = '$_serverApi/report';

}
