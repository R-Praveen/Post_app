import 'package:flutter/material.dart';
import 'package:posts_app/routes/routes.dart';

extension NavigatorStateExtensions on NavigatorState {
  Future<T?> pushNamedAndRemoveUntilWithoutAnimation<T extends Object>(
    String newRouteName,
    RoutePredicate predicate, {
    dynamic arguments,
  }) =>
      pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, _, __) => routes[newRouteName]!(context),
            settings: RouteSettings(
              arguments: arguments,
            )),
        (_) => false,
      );
}
