import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mai/feature/info/screens/sport/sport_page_cubit.dart';

import '../../../../assets/assets.dart';
import '../../models/campus.dart';
import '../../models/live.dart';
import 'organizations_page_cubit.dart';

class OrganizationsPage extends StatelessWidget {
  const OrganizationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = OrganizationsPageCubit();
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
            'Студенческие организации',
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
        body: BlocBuilder<OrganizationsPageCubit, OrganizationsPageState>(
          builder: (context, state) {
            if (state is OrganizationsPageLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is OrganizationsPageLoadedState) {
              return OrganizationsLoadedView(organizations: state.organizations);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class OrganizationsLoadedView extends StatelessWidget {
  const OrganizationsLoadedView({Key? key, required this.organizations})
      : super(key: key);
  final List<StudentOrganization> organizations;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var organization in organizations)
          ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: colorBorder, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(organization.name),
            subtitle: Column(
              children: [
                Text(organization.contact),
              ],
            ),
          )
      ],
    );
  }
}
