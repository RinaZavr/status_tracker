import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/config/router/routes_consts.dart';
import 'package:status_tracker/scr/features/auth/view/auth_screen.dart';
import 'package:status_tracker/scr/features/calendar/view/calendar_screen.dart';
import 'package:status_tracker/scr/splash_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(
  path: AppRoutesConsts.splash,
)
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<AuthRoute>(
  path: AppRoutesConsts.auth,
)
class AuthRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthScreen();
  }
}

@TypedGoRoute<CalendarRoute>(
  path: AppRoutesConsts.calendar,
)
class CalendarRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CalendarScreen();
  }
}
