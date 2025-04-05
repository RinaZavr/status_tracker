import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/main.dart';
import 'package:status_tracker/scr/common/utils/error_listener_screen.dart';
import 'package:status_tracker/scr/config/router/router.dart';
import 'package:status_tracker/scr/config/styles/cubit/theme_cubit.dart';
import 'package:status_tracker/scr/config/styles/themes.dart';
import 'package:status_tracker/scr/features/auth/bloc/auth_bloc.dart';
import 'package:status_tracker/scr/features/calendar/bloc/calendar_bloc.dart';
import 'package:status_tracker/scr/features/incidents/cubit/incidents_cubit.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter _router;

  @override
  void initState() {
    _router = AppRouter.router;

    super.initState();
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetMeEvent()),
        ),
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
        BlocProvider(
          create: (context) => IncidentsCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return CalendarControllerProvider<Incident>(
            controller: EventController<Incident>(),
            child: MaterialApp.router(
              scaffoldMessengerKey: scaffoldMessengerKey,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return ErrorListener(child: child!);
              },
              theme: state.isDark
                  ? AppThemes.dark(context)
                  : AppThemes.light(context),
              supportedLocales: const [Locale('ru')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              routerConfig: _router,
            ),
          );
        },
      ),
    );
  }
}
