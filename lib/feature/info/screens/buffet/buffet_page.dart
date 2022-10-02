import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/feature/info/screens/buffet/buffet_page_cubit.dart';

import '../../../../assets/assets.dart';
import '../../models/campus.dart';

class BuffetPage extends StatelessWidget {
  const BuffetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = BuffetPageCubit();
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
            'Cтоловые и буфеты',
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
        body: BlocBuilder<BuffetPageCubit, BuffetPageState>(
          builder: (context, state) {
            if (state is BuffetLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is BuffetPageLoadedState) {
              return BuffetLoadedView(
                buffets: state.buffets,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class BuffetLoadedView extends StatelessWidget {
  const BuffetLoadedView({Key? key, required this.buffets}) : super(key: key);
  final List<Buffet> buffets;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        for (var buffet in buffets)
          BuffetWidget(
            buffet: buffet,
          )
      ],
    );
  }
}

class BuffetWidget extends StatelessWidget {
  const BuffetWidget({Key? key, required this.buffet}) : super(key: key);
  final Buffet buffet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          Positioned(
              child: Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 16),
            decoration: BoxDecoration(
              border: Border.all(color: colorBorder),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: double.infinity,
                    child: Text(
                      buffet.address,
                      style: bodyText,
                    )),
                Text(buffet.workTime, style: hintText,),
              ],
            ),
          )),
          Positioned(
            left: 16,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: const BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(
                buffet.name,
                style: subtitle1BloodOnBg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
