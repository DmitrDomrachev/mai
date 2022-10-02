import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_provider/info_web.dart';
import '../../models/campus.dart';

part 'buffet_page_state.dart';

class BuffetPageCubit extends Cubit<BuffetPageState> {
  BuffetPageCubit() : super(BuffetLoadingState());

  void loadData() async {
    final buffets = await CampusWebDataProvider().getBuffets();
    if (buffets != null) {
      emit(BuffetPageLoadedState(buffets));
    }
  }
}
