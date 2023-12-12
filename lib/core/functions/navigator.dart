import 'package:flutter/material.dart';
import 'package:pharmageddon_mobile/model/screen_arguments.dart';

void pushNamedAndRemoveUntil(String route, BuildContext context,
    {Object? arguments}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    (route) => false, // This will remove all screens
    arguments: arguments,
  );
}

Future<T?> pushNamed<T extends Object?>(String route, BuildContext context,
    {Map<String, dynamic>? arguments}) {
  return Navigator.pushNamed(context, route,
      arguments: ScreenArguments(arguments ?? {}));
}
//
// void navigatorAndFinish(BuildContext context, Widget widget) =>
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (context) => widget,
//       ),
//       (Route<dynamic> route) => false,
//     );
//
// void navigatorTo(BuildContext context, Widget widget) => Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => widget,
//       ),
//     );

// void goTo(String to, BuildContext context) {
//   GoRouter.of(context).go(to);
// }
//
// void pushTo(String to, BuildContext context) {
//   GoRouter.of(context).push(to);
// }
