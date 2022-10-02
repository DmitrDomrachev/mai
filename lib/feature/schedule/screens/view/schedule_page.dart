import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/assets/assets.dart';
import 'package:mai/feature/schedule/models/models.dart';
import 'package:mai/feature/schedule/screens/bloc/schedule_page_bloc.dart';
import 'package:mai/feature/schedule/screens/view/calendar_widget.dart';
import 'package:mai/feature/search_group/view/search_group_page.dart';
import 'package:mai/feature/setting/models/group.dart';

import '../../../utils/data_utils.dart';
import '../cubit/calendar_cubit.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchedulePageBloc()..add(SchedulePageRequestData()),
      child: BlocListener<SchedulePageBloc, SchedulePageState>(
        listener: (context, state) {
          if (state is SchedulePageOldScheduleState) {
            _showOldScheduleSnack(context);
          }
        },
        child: SchedulePageView(),
      ),
    );
  }
}

class SchedulePageView extends StatelessWidget {
  const SchedulePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchedulePageBloc, SchedulePageState>(
      builder: (context, state) {
        if (state is SchedulePageInitial) {
          return Container(
            color: Colors.white,
          );
        }
        if (state is SchedulePageNoGroupState) {
          return const SchedulePageNoGroup();
        }
        if (state is SchedulePageLoadingState) {
          return SchedulePageLoading(
            group: state.group,
          );
        }
        if (state is SchedulePageLoadedState) {
          return const SchedulePageLoaded();
        }
        if (state is SchedulePageLoadingErrorState) {
          return SchedulePageLoadingError(group: state.group);
        }
        return Container(
          color: Colors.teal,
        );
      },
    );
  }
}

class ScheduleDaySchedule extends StatelessWidget {
  const ScheduleDaySchedule({Key? key, this.day}) : super(key: key);
  final Day? day;

  @override
  Widget build(BuildContext context) {
    if (day == null) {
      return const Center(
        child: Text('В этот день нет пар'),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          for (Subject subject in day?.subjects ?? [])
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: colorBorder, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Container(
                  alignment: Alignment.center,
                  height: 34,
                  width: 34,
                  decoration: const BoxDecoration(
                      color: colorPrimary, shape: BoxShape.circle),
                  child: Text(
                    subject.number,
                    style: subtitle1OnBg,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    subject.name,
                    style: subtitle1Blood,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${subject.timeStart} - ${subject.timeEnd}',
                        style: hintText,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      subject.lector.name != ''
                          ? Text(
                              subject.lector.name,
                              style: bodyText,
                            )
                          : Container(),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            subject.room.name,
                            style: bodyText,
                          ),
                          Text(
                            subject.type,
                            style: hintText,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class SchedulePageLoaded extends StatelessWidget {
  const SchedulePageLoaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SchedulePageBloc>();
    return BlocBuilder<SchedulePageBloc, SchedulePageState>(
      builder: (context, state) {
        if (state is SchedulePageLoadedState) {
          // if (!isOneDay(state.schedule.loadedDate, DateTime.now())){
          //   _showOldScheduleSnack(context);
          // }
          // log('build schedule ${(state as SchedulePageLoadedState)}');
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate:
                            state.schedule.getDatesMap()[state.pageIndex] ??
                                DateTime.now(),
                        firstDate: state.schedule.startDate,
                        lastDate: state.schedule.endTime);
                    if (newDate != null) {
                      bloc.add(SchedulePageSelectDay(newDate));
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                  color: Colors.black,
                )
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                state.group.name,
                style: listItemTitle,
              ),
            ),
            body: Column(
              children: [
                CalendarWidget(
                  startDate: state.schedule.startDate,
                  endDate: state.schedule.endTime,
                  selectedDateTime: DateTime.now(),
                  currentDateTime: DateTime.now(),
                  onDaySelected: (day) {
                    context
                        .read<SchedulePageBloc>()
                        .add(SchedulePageSelectDay(day));
                  },
                ),
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      context
                          .read<SchedulePageBloc>()
                          .add(SchedulePageSwipe(index));
                    },
                    controller: state.controller,
                    itemCount: state.schedule.getSchedulePageCount(),
                    itemBuilder: (context, index) {
                      return ScheduleDaySchedule(
                        day: state.schedule.getDaySchedule(
                            state.schedule.getDatesMap()[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class SchedulePageNoGroup extends StatelessWidget {
  const SchedulePageNoGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Группа не выбрана',
            style: listItemTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Чтобы увидеть расписание, необходимо выбрать учебную группу',
                style: hintText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: const BorderSide(color: colorPrimary),
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  // context.read<SettingPageCubit>().init();
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return const SearchGroupPage();
                  })).then((value) => context
                      .read<SchedulePageBloc>()
                      .add(SchedulePageRequestData()));
                  // onAddGroup(context);
                },
                child: const Text('Добавить группу'),
              )
            ],
          ),
        ));
  }
}

class SchedulePageLoading extends StatelessWidget {
  const SchedulePageLoading({Key? key, required this.group}) : super(key: key);

  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          group.name,
          style: listItemTitle,
        ),
      ),
      body: const Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class SchedulePageLoadingError extends StatelessWidget {
  const SchedulePageLoadingError({Key? key, required this.group})
      : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            group.name,
            style: listItemTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Произошла ошибка при загрузке расписание.'),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    side: const BorderSide(color: colorPrimary),
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  context
                      .read<SchedulePageBloc>()
                      .add(SchedulePageRequestData());
                },
                child: const Text('Повторить попытку'),
              )
            ],
          ),
        ));
  }
}

void _showOldScheduleSnack(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      const SnackBar(
        content: Text('Произошла ошибка при обновлении расписания. Показана последняя сохраненная версия. '),
      ),
    );
}
