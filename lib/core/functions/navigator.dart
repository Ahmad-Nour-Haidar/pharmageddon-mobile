import 'package:flutter/material.dart';

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
    {Object? arguments}) {
  return Navigator.pushNamed(context, route, arguments: arguments);
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
