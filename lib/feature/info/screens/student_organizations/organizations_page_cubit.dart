import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mai/feature/info/models/live.dart';

import '../../data_provider/info_web.dart';

part 'organizations_page_state.dart';

class OrganizationsPageCubit extends Cubit<OrganizationsPageState> {
  OrganizationsPageCubit() : super(OrganizationsPageLoadingState());

  void loadData() async {
    final organizations = await CampusWebDataProvider().getStudentOrganizations();
    if (organizations != null) {
      emit(OrganizationsPageLoadedState(organizations));
    }
  }
}
