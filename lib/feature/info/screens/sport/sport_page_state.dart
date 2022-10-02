part of 'sport_page_cubit.dart';

abstract class SportPageState extends Equatable {
  const SportPageState();
}

class SportPageLoadingState extends SportPageState {
  @override
  List<Object> get props => [];
}

class SportPageLoadedState extends SportPageState {
  final List<Stadium> stadiums;

  const SportPageLoadedState(this.stadiums);
  @override
  List<Object> get props => [];
}