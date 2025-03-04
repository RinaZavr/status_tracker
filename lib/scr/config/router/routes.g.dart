// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authRoute,
      $calendarRoute,
      $createRecordRoute,
      $myRecordsRoute,
    ];

RouteBase get $authRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthRouteExtension._fromState,
    );

extension $AuthRouteExtension on AuthRoute {
  static AuthRoute _fromState(GoRouterState state) => AuthRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $calendarRoute => GoRouteData.$route(
      path: '/calendar',
      factory: $CalendarRouteExtension._fromState,
    );

extension $CalendarRouteExtension on CalendarRoute {
  static CalendarRoute _fromState(GoRouterState state) => CalendarRoute();

  String get location => GoRouteData.$location(
        '/calendar',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createRecordRoute => GoRouteData.$route(
      path: '/create-record',
      factory: $CreateRecordRouteExtension._fromState,
    );

extension $CreateRecordRouteExtension on CreateRecordRoute {
  static CreateRecordRoute _fromState(GoRouterState state) =>
      CreateRecordRoute();

  String get location => GoRouteData.$location(
        '/create-record',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $myRecordsRoute => GoRouteData.$route(
      path: '/my-records',
      factory: $MyRecordsRouteExtension._fromState,
    );

extension $MyRecordsRouteExtension on MyRecordsRoute {
  static MyRecordsRoute _fromState(GoRouterState state) => MyRecordsRoute();

  String get location => GoRouteData.$location(
        '/my-records',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
