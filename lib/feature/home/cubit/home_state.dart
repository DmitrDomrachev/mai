part of 'home_cubit.dart';

enum HomeTab { info, schedule, setting }

class HomeState extends Equatable {
  final HomeTab tab;

  const HomeState({this.tab = HomeTab.schedule});

  @override
  List<Object> get props => [tab];
}
