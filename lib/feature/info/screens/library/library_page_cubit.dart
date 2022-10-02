import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_provider/info_web.dart';
import '../../models/campus.dart';

part 'library_page_state.dart';

class LibraryPageCubit extends Cubit<LibraryPageState> {
  LibraryPageCubit() : super(LibraryLoadingState());

  void loadData() async {
    final libraries = await CampusWebDataProvider().getLibraries();
    if (libraries != null) {
      emit(LibraryPageLoadedState(libraries));
    }
  }
}
