import 'package:flutter/material.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/features/auth/view/auth_screen.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/calendar_widget.dart';
import 'package:status_tracker/scr/features/records/create/view/create_record_screen.dart';
import 'package:status_tracker/scr/features/records/my/view/my_records_screen.dart';
import 'package:theme_provider/theme_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String? name = 'Имя Фамилия';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Календарь',
          style: context.textExt.titleMiddle,
        ),
        automaticallyImplyLeading: false,
        actions: [
          CustomButton(
            child: const Icon(AppIcons.darkThemeIcon),
            onPressed: () {
              ThemeProvider.controllerOf(context).currentThemeId == 'dark'
                  ? ThemeProvider.controllerOf(context).setTheme('light')
                  : ThemeProvider.controllerOf(context).setTheme('dark');
            },
          ),
          const SizedBox(width: 10),
          if (name != null)
            CustomButton(
              child: const Icon(AppIcons.recordsIcon),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const MyRecordsScreen();
                  },
                );
              },
            ),
          if (name != null) const SizedBox(width: 10),
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            color: context.colorExt.backgroundColor,
            onSelected: (value) {
              setState(() {
                name = null;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'logout',
                child: Center(
                  child: Text(
                    'Выйти',
                    style: context.textExt.normal.copyWith(color: Colors.red),
                  ),
                ),
              ),
            ],
            child: name != null
                ? Text(
                    name!,
                    style: context.textExt.normal,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : CustomButton(
                    child: Text('Войти', style: context.textExt.normal),
                    onPressed: () async {
                      name = await showDialog<String>(
                        context: context,
                        builder: (context) {
                          return const AuthScreen();
                        },
                      );
                      setState(() {});
                    },
                  ),
          ),
          const SizedBox(width: 16),

          // IconButton(
          //   icon: Text(
          //     name,
          //     style: context.textExt.normal,
          //   ),
          //   onPressed: () {
          //     PopupMenuButton<String>(
          //       position: PopupMenuPosition.under,
          //       onSelected: (value) {
          //         setState(() {
          //           name = value;
          //         });
          //       },
          //       itemBuilder: (context) => const [
          //         PopupMenuItem(
          //           value: 'Имя Фамилия',
          //           child: Text('Имя Фамилия'),
          //         ),
          //         PopupMenuItem(
          //           value: 'Имя Фамилия2',
          //           child: Text('Имя Фамилия2'),
          //         ),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
      body: Stack(
        children: [
          const CalendarWidget(),
          if (name != null)
            Positioned(
              bottom: 30,
              right: 30,
              child: CustomButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CreateRecordScreen();
                    },
                  );
                },
                backgroundColor: context.colorExt.buttonColor,
                child: const Icon(AppIcons.addIcon),
              ),
            ),
        ],
      ),
    );
  }
}
