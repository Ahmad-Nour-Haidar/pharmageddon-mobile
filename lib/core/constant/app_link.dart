class AppLink {
  AppLink._();

  // http://127.0.0.1/api/auth/register

  // static const _host = '10.0.2.2:8000';

  // static const _host = 'localhost:8000';
  //
  // static const _host = '192.168.43.76:8000';
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
}