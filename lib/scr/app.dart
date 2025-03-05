import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:status_tracker/scr/config/router/router.dart';
import 'package:status_tracker/scr/config/styles/themes.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/cell_calendar_widget.dart';
import 'package:theme_provider/theme_provider.dart';

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

    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      themes: [
        AppTheme(
          id: 'light',
          data: AppThemes.light,
          description: 'light',
        ),
        AppTheme(
          id: 'dark',
          data: AppThemes.dark,
          description: 'dark',
        ),
      ],
      child: ThemeConsumer(
        child: Builder(
          builder: (context) {
            return CalendarControllerProvider<Incident>(
              controller: EventController<Incident>(),
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: ThemeProvider.controllerOf(context).theme.data,
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
      ),
    );
  }
}
