import 'package:api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status_tracker/scr/common/consts/icons.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/common/widgets/custom_button.dart';
import 'package:status_tracker/scr/config/router/routes.dart';
import 'package:status_tracker/scr/config/styles/colors.dart';
import 'package:status_tracker/scr/config/styles/cubit/theme_cubit.dart';
import 'package:status_tracker/scr/features/auth/bloc/auth_bloc.dart';
import 'package:status_tracker/scr/features/calendar/bloc/calendar_bloc.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/calendar_widget.dart';
import 'package:status_tracker/scr/features/incidents/create/view/create_record_screen.dart';
import 'package:status_tracker/scr/features/incidents/my/view/my_records_screen.dart';

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
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomButton(
                    child: const Icon(AppIcons.recordsIcon),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const MyRecordsScreen();
                        },
                      ).then((value) {
                        if (value == true) {
                          context
                              .read<CalendarBloc>()
                              .add(GetMonthEvents(date: DateTime.now()));
                        }
                      });
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return PopupMenuButton<String>(
                  position: PopupMenuPosition.under,
                  color: context.colorExt.backgroundColor,
                  onSelected: (value) {
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'logout',
                      child: Center(
                        child: Text(
                          'Выйти',
                          style: context.textExt.normal
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      '${DioClient().user?.name ?? ''} '
                      '${DioClient().user?.surname ?? ''}',
                      style: context.textExt.normal,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }
              if (state is AuthNotAuthenticated) {
                return CustomButton(
                  child: Text(
                    'Войти',
                    style: context.textExt.normal,
                  ),
                  onPressed: () {
                    AuthRoute().push(context);
                  },
                );
              }
              return const SizedBox();
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: CalendarWidget()),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return Padding(
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
                      ).then((value) {
                        if (value == true) {
                          context
                              .read<CalendarBloc>()
                              .add(GetMonthEvents(date: DateTime.now()));
                        }
                      });
                    },
                    backgroundColor: context.colorExt.buttonColor,
                    isExpanded: true,
                    child: const Icon(
                      AppIcons.addIcon,
                      color: AppColors.raisinblacksecond,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
