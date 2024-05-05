import 'package:ask_pdf/core/route/router_constans.dart';
import 'package:ask_pdf/features/auth/login/view/login.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

pushNamed({
  required BuildContext context,
  required String routeName,
  dynamic arguments,
}) {
  if (arguments != null) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  } else {
    Navigator.pushNamed(context, routeName);
  }
}

pushNamedAndClearStack(
  BuildContext context,
  String routeName,
) {
  Navigator.of(context).pushAndRemoveUntil(
      MyRouter.generateRoute(RouteSettings(
        name: routeName,
      )),
      (Route<dynamic> route) => false);
}
