
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/assets/assets.dart';
import 'package:mai/feature/utils/utils.dart';

import '../bloc/schedule_page_bloc.dart';
import '../cubit/calendar_cubit.dart';

class CalendarWidget extends StatelessWidget {
  CalendarWidget(
      {Key? key,
      required this.currentDateTime,
      required this.selectedDateTime,
      required this.startDate,
      required this.endDate,
      required this.onDaySelected})
      : super(key: key);

  final DateTime currentDateTime;
  DateTime selectedDateTime;
  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime dateTime) onDaySelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarCubit(
          currentDateTime: currentDateTime,
          selectedDateTime: selectedDateTime,
          startDate: startDate,
          endDate: endDate,
          onDaySelected: onDaySelected),
      child: BlocBuilder<SchedulePageBloc, SchedulePageState>(
        builder: (context, stateParent) {
          context.read<CalendarCubit>().selectDate(
              (stateParent as SchedulePageLoadedState).selectedDate);
          return BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, state) {
              if (state is CalendarInitial) {
                return Container(
                  height: 80,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                        child: Text(
                            '${state.selectedDate.day} ${getMonthName(state.selectedDate)}', style: subtitle1,),
                      ),
                      Expanded(
                        child: PageView.builder(
                          itemCount: state.weeks.length,
                          controller: state.controller,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (var day in state.weeks[index])
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<CalendarCubit>()
                                          .selectDate(day);
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      decoration: BoxDecoration(
                                          color:
                                              isOneDay(state.selectedDate, day)
                                                  ? colorPrimary
                                                  : null,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                            color:
                                                isOneDay(state.currentDate, day)
                                                    ? colorPrimary
                                                    : Colors.white,
                                          )),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      child: Column(
                                        children: [
                                          Text(
                                            day.day.toString(),
                                            style: isOneDay(
                                                    state.selectedDate, day)
                                                ? subtitle1BloodOnBg
                                                : subtitle1Blood,
                                          ),
                                          Text(
                                            getWeekdayName(day),
                                            style: isOneDay(
                                                    state.selectedDate, day)
                                                ? hintText2OnBg
                                                : hintText2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
