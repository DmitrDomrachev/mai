import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data_provider/info_web.dart';
import '../../models/live.dart';

part 'creative_page_state.dart';

class CreativePageCubit extends Cubit<CreativePageState> {
  CreativePageCubit() : super(CreativePageLoadingState());

  void loadData() async {
    final organizations = await CampusWebDataProvider().getCreativeOrganizations();
    if (organizations != null) {
      emit(CreativePageLoadedState(organizations));
    }
  }

}
