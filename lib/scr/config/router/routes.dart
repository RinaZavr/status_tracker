import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/config/router/routes_consts.dart';
import 'package:status_tracker/scr/features/auth/view/auth_screen.dart';
import 'package:status_tracker/scr/features/calendar/view/calendar_screen.dart';
import 'package:status_tracker/scr/features/records/create/view/create_record_screen.dart';
import 'package:status_tracker/scr/features/records/list/view/my_records_screen.dart';

part 'routes.g.dart';

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

@TypedGoRoute<CreateRecordRoute>(
  path: AppRoutesConsts.createRecord,
)
class CreateRecordRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CreateRecordScreen();
  }
}

@TypedGoRoute<MyRecordsRoute>(
  path: AppRoutesConsts.myRecords,
)
class MyRecordsRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MyRecordsScreen();
  }
}
