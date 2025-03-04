import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/router/routes.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/calendar_widget.dart';
import 'package:theme_provider/theme_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Календарь',
          style: context.textExt.titleMiddle,
        ),
        actions: [
          CustomButton(
            child: const Icon(AppIcons.darkThemeIcon),
            onPressed: () {
              log(
                ThemeProvider.controllerOf(context).currentThemeId,
              );
              ThemeProvider.controllerOf(context).currentThemeId == 'dark'
                  ? ThemeProvider.controllerOf(context).setTheme('light')
                  : ThemeProvider.controllerOf(context).setTheme('dark');
            },
          ),
          const SizedBox(width: 10),
          CustomButton(
            child: const Icon(AppIcons.recordsIcon),
            onPressed: () {
              MyRecordsRoute().push(context);
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Text(
              'Имя Фамилия',
              style: context.textExt.normal,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: CustomButton(
        onPressed: () {
          CreateRecordRoute().push(context);
        },
        backgroundColor: context.colorExt.buttonColor,
        child: const Icon(AppIcons.addIcon),
      ),
      body: const CalendarWidget(),
    );
  }
}
