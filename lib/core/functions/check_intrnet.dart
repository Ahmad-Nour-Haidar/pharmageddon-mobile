import 'dart:io';

Future<bool> checkInternet() async {
  try {
    // printme.green('check');
    var result = await InternetAddress.lookup("google.com");
    // printme.green(result);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
    return false;
  } on SocketException {
    // printme.green(e);
    return false;
  }
}
