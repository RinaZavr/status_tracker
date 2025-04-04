import 'package:api/api_client.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:status_tracker/scr/common/extensions/context_extensions.dart';
import 'package:status_tracker/scr/features/calendar/bloc/calendar_bloc.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/cell_calendar_widget.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/header_calendar_widget.dart';
import 'package:status_tracker/scr/features/calendar/view/widgets/weekday_calendar_widget.dart';
import 'package:status_tracker/scr/features/incidents/list/view/list_records_screen.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final GlobalKey<MonthViewState> monthState = GlobalKey<MonthViewState>();
  final EventController<Incident> controller = EventController<Incident>();

  DateTime _currentDate =
      DateTime.now(); // Текущая дата для отслеживания месяца

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    context.read<CalendarBloc>().add(
          GetMonthEvents(
            date: DateTime.now(),
          ),
        );
    super.initState();
  }

  Future<void> _onRefresh() async {
    context.read<CalendarBloc>().add(
          GetMonthEvents(
            date: _currentDate,
          ),
        );

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: context.colorExt.textColor,
            ),
          );
        }
        if (state is CalendarErrorState) {
          return Center(
            child: Text(
              state.error,
              style: context.textExt.normal,
            ),
          );
        }
        if (state is CalendarLoadedState) {
          controller
            ..removeWhere((_) => true)
            ..addAll(state.events);
          final weeksInMonth = _getWeeksInMonth(_currentDate);

          // Доступная высота календаря
          final availableHeight = MediaQuery.of(context).size.height * 3 / 4;

          // Рассчитываем cellAspectRatio
          final cellAspectRatio = _calculateCellAspectRatio(
            availableHeight,
            weeksInMonth,
            MediaQuery.of(context).size.width,
          );

          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MonthView<Incident>(
                key: monthState,
                initialMonth: _currentDate,
                controller: controller,
                showBorder: false,
                hideDaysNotInMonth: true,
                cellAspectRatio: cellAspectRatio,
                headerBuilder: (date) {
                  return HeaderCalendarWidget(
                    currentDate: _currentDate,
                    onTapNext: () {
                      setState(() {
                        _currentDate =
                            DateTime(_currentDate.year, _currentDate.month + 1);
                      });
                      context.read<CalendarBloc>().add(
                            GetMonthEvents(
                              date: _currentDate,
                            ),
                          );
                      monthState.currentState
                          ?.nextPage(duration: const Duration(seconds: 1));
                    },
                    onTapPrevious: () {
                      setState(() {
                        _currentDate =
                            DateTime(_currentDate.year, _currentDate.month - 1);
                      });

                      context.read<CalendarBloc>().add(
                            GetMonthEvents(
                              date: _currentDate,
                            ),
                          );
                      monthState.currentState
                          ?.previousPage(duration: const Duration(seconds: 1));
                    },
                    onTapReset: () {
                      setState(() {
                        _currentDate = DateTime.now();
                      });

                      context.read<CalendarBloc>().add(
                            GetMonthEvents(
                              date: _currentDate,
                            ),
                          );
                      monthState.currentState?.animateToMonth(_currentDate);
                    },
                  );
                },
                weekDayBuilder: (day) {
                  return WeekdayCalendarWidget(
                    day: day,
                  );
                },
                cellBuilder:
                    (date, events, isToday, isInMonth, hideDaysNotInMonth) {
                  return CellCalendarWidget(
                    date: date,
                    events: events,
                    isToday: isToday,
                    isInMonth: isInMonth,
                  );
                },
                onCellTap: (events, date) {
                  if (date.month ==
                      monthState.currentState!.currentDate.month) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListRecordsScreen(
                          date: date,
                          events: events,
                        );
                      },
                    );
                  }
                },
                // onPageChange: (date, direction) async {
                //   setState(() {
                //     _currentDate = date;
                //   });
                // },
              ),
            ),
          );
        }

        return Container();
      },
    );
  }

  // Функция для расчета количества недель в месяце
  int _getWeeksInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);

    // Количество дней в месяце
    final daysInMonth = lastDayOfMonth.day;

    // Номер дня недели для первого дня месяца
    // (1 = понедельник, 7 = воскресенье)
    final firstWeekday = firstDayOfMonth.weekday;

    // Количество недель
    return ((daysInMonth + firstWeekday - 1) / 7).ceil();
  }

  // Функция для расчета cellAspectRatio
  double _calculateCellAspectRatio(
    double availableHeight,
    int weeksInMonth,
    double screenWidth,
  ) {
    // Ширина ячейки = ширина экрана / 7 (7 дней в неделе)
    final cellWidth = screenWidth / 7;

    // Высота ячейки = доступная высота / количество недель
    final cellHeight = availableHeight / weeksInMonth;

    // cellAspectRatio = ширина ячейки / высота ячейки
    return cellWidth / cellHeight;
  }
}
