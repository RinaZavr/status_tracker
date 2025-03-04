import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/config/router/routes.dart';
import 'package:status_tracker/scr/features/calendar/view/calendar_screen.dart';

abstract class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    initialLocation: CalendarRoute().location,
    errorBuilder: (context, state) {
      return const CalendarScreen();
    },
  );
}
