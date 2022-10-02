import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_provider/info_web.dart';
import '../../models/live.dart';

part 'sport_page_state.dart';

class SportPageCubit extends Cubit<SportPageState> {
  SportPageCubit() : super(SportPageLoadingState());

  void loadData() async {
    final stadiums = await CampusWebDataProvider().getStadiums();
    if (stadiums != null) {
      emit(SportPageLoadedState(stadiums));
    }
  }
}
