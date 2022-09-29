import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/assets/assets.dart';

import '../cubit/search_group_cubit.dart';

class SearchGroupPage extends StatelessWidget {
  const SearchGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchGroupCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Добавление группы',
            style: listItemTitle,
          ),
        ),
        body: BlocListener<SearchGroupCubit, SearchGroupState>(
          listener: (context, state) {
            if (state is SearchGroupDone) {
              Navigator.of(context).pop();
            }
          },
          child: const SearchGroupView(),
        ),
      ),
    );
  }
}

class SearchGroupView extends StatelessWidget {
  const SearchGroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchGroupCubit, SearchGroupState>(
      builder: (context, state) {
        if (state is SearchGroupInitial) {
          final cubit = context.read<SearchGroupCubit>();
          return Column(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                      height: 60,
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Поиск',
                          border: OutlineInputBorder(),
                        ),

                        onChanged: (text) {
                          cubit.inputSearchName(text);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                      );
                    },
                    itemCount: state.searchResult.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          cubit.chooseGroup(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(
                              state.searchResult[index].name,
                              style: listItemTitle,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.searchResult[index].fac),
                                Text(
                                    '${state.searchResult[index].course} курс'),
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        }

        return Container();
      },
    );
  }
}
