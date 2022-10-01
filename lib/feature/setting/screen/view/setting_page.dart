import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/assets/colors.dart';
import 'package:mai/assets/text_styles.dart';
import 'package:mai/feature/search_group/view/search_group_page.dart';
import 'package:mai/feature/setting/models/group.dart';

import '../bloc/setting_page_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Настройки',
          style: listItemTitle,
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: colorBorder,
              height: 1,
            )),
      ),
      body: BlocProvider(
        create: (context) {
          final cubit = SettingPageCubit();
          cubit.init();
          return cubit;
        },
        child: Builder(
            builder: (context) {
              return BlocListener<SettingPageCubit, SettingPageState>(
                listener: (context, state) {
                  if(state is SettingPageAddGroup) {
                    context.read<SettingPageCubit>().init();
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return const SearchGroupPage();
                    })).then((value) => context.read<SettingPageCubit>().init());
                  }
                },
                child: const SettingScreen(),
              );
            }
        ),
      ),
    );
  }
}

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingPageCubit, SettingPageState>(
      builder: (context, state) {
        if (state is SettingPageInitial) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SelectedGroup(
                    group: state.selectedGroup,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SavedGroups(
                    groups: state.groups,
                    selectedGroup: state.selectedGroup,
                    onDeleted: (group) {
                      context.read<SettingPageCubit>().deleteGroup(group);
                    },
                    onSelected: (group) {
                      context.read<SettingPageCubit>().selectGroup(group);
                    },
                    onAddGroup: (BuildContext context) {
                      context.read<SettingPageCubit>().addGroup();
                    },
                  )
                ],
              ),
            ),
          );
        }
        return Container(
          // height: double.infinity,
          // color: Colors.red,
        );
      },
    );
  }
}

class SelectedGroup extends StatelessWidget {
  const SelectedGroup({Key? key, this.group}) : super(key: key);
  final Group? group;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 134,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            gradient: LinearGradient(colors: [
              colorPrimary,
              colorGradientStart,
            ])),
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: group != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group?.name ?? '',
              style: headline5OnBg,
            ),
            Text(
              group?.fac ?? '',
              style: subtitle1OnBg,
            ),
            Text(
              group?.level ?? '',
              style: subtitle1OnBg,
            ),
            Text(
              '${group?.course.toString()} курс',
              style: subtitle1OnBg,
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Группа не выбрана',
              style: headline5OnBg,
            )
          ],
        ));
  }
}

class SavedGroups extends StatelessWidget {
  const SavedGroups({
    Key? key,
    required this.groups,
    required this.selectedGroup,
    required this.onSelected,
    required this.onDeleted,
    required this.onAddGroup,
  }) : super(key: key);

  final List<Group> groups;
  final Group? selectedGroup;
  final Function(Group group) onSelected;
  final Function(Group group) onDeleted;
  final Function(BuildContext context) onAddGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ваши группы',
          style: subtitle1,
        ),
        for (var gr in groups)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: (){
                log('onTap on $gr');
                onSelected(gr);
              },
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: colorBorder, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                leading: Checkbox(
                  shape: const CircleBorder(),
                  value: gr == selectedGroup,
                  onChanged: (bool? value) {
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel_outlined),
                  onPressed: () {
                    onDeleted(gr);
                  },
                ),
                title: Text(
                  gr.name,
                  style: listItemTitle,
                ),
              ),
            ),
          ),
        const SizedBox(
          height: 8,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              side: const BorderSide(color: colorPrimary),
              minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            onAddGroup(context);
          },
          child: const Text('Добавить группу'),
        )
      ],
    );
  }
}
