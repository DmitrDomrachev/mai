
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/feature/home/cubit/home_cubit.dart';
import 'package:mai/feature/info/screens/info_page.dart';

import '../../schedule/screens/view/schedule_page.dart';
import '../../setting/screen/view/setting_page.dart';
import '../../info/screens/map/campus_scheme_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        StatelessWidget contentWidget = Container(
          color: Colors.green,
        );
        if (state.tab == HomeTab.schedule){
          contentWidget = SchedulePage();
        }
        if (state.tab == HomeTab.setting) {
          contentWidget = SettingPage();
        }
        if (state.tab == HomeTab.info) {
          contentWidget = InfoPage();
        }
        return Scaffold(
          body: contentWidget,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              context.read<HomeCubit>().setTab(HomeTab.values[index]);
            },
            currentIndex: selectedTab.index,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline), label: 'Инфо'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'Расписание'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Настройки'),
            ],
          ),
        );
      },
    );
  }
}
