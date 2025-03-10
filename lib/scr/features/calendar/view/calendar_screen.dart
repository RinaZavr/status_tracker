import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/router/routes.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/config/styles/cubit/theme_cubit.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/calendar_widget.dart';
import 'package:status_tracker/scr/features/records/create/view/create_record_screen.dart';
import 'package:status_tracker/scr/features/records/my/view/my_records_screen.dart';

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
            child: context.watch<ThemeCubit>().state.isDark
                ? const Icon(AppIcons.lightThemeIcon)
                : const Icon(AppIcons.darkThemeIcon),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
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
                ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      name!,
                      style: context.textExt.normal,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : CustomButton(
                    child: Text(
                      'Войти',
                      style: context.textExt.normal,
                    ),
                    onPressed: () {
                      AuthRoute().push(context).then((value) {
                        setState(() {
                          name = value;
                        });
                      });
                    },
                  ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: CalendarWidget()),
          if (name != null)
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 16,
              ),
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
                isExpanded: true,
                child: const Icon(
                  AppIcons.addIcon,
                  color: AppColors.raisinblacksecond,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
