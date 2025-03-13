import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/config/router/router.dart';
import 'package:status_tracker/scr/config/styles/cubit/theme_cubit.dart';
import 'package:status_tracker/scr/config/styles/themes.dart';

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

    // return ThemeProvider(
    //   saveThemesOnChange: true,
    //   loadThemeOnInit: true,
    //   defaultThemeId: 'dark',
    //   themes: [
    //     AppTheme(
    //       id: 'light',
    //       data: AppThemes.light(context),
    //       description: 'light',
    //     ),
    //     AppTheme(
    //       id: 'dark',
    //       data: AppThemes.dark(context),
    //       description: 'dark',
    //     ),
    //   ],
    //   child: ThemeConsumer(
    //     child: Builder(
    //       builder: (context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return CalendarControllerProvider<Incident>(
            controller: EventController<Incident>(),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
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
    //       },
    //     ),
    //   ),
    // );
  }
}
