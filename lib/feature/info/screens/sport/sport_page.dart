import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/feature/info/screens/sport/sport_page_cubit.dart';

import '../../../../assets/assets.dart';
import '../../models/campus.dart';
import '../../models/live.dart';

class SportPage extends StatelessWidget {
  const SportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = SportPageCubit();
        cubit.loadData();
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Спортивные секции',
            style: listItemTitle,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: colorBorder,
              height: 1,
            ),
          ),
        ),
        body: BlocBuilder<SportPageCubit, SportPageState>(
          builder: (context, state) {
            if (state is SportPageLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is SportPageLoadedState) {
              return SportLoadedView(stadiums: state.stadiums);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class SportLoadedView extends StatelessWidget {
  const SportLoadedView({Key? key, required this.stadiums}) : super(key: key);
  final List<Stadium> stadiums;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var stadium in stadiums)
          Column(
            children: [
              Text(stadium.name, style: headline5),
              Text(stadium.address),
              for (var section in stadium.sections)
                Column(
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: colorBorder, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(section.name),
                      subtitle: Column(
                        children: [
                          Text(section.contactName),
                          Text(section.contact),
                        ],
                      ),
                    )
                  ],
                )
            ],
          )
      ],
    );
  }
}
