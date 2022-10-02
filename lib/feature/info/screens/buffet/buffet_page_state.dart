part of 'buffet_page_cubit.dart';

abstract class BuffetPageState extends Equatable {
  const BuffetPageState();
}

class BuffetPageLoadedState extends BuffetPageState {
  final List<Buffet> buffets;

  const BuffetPageLoadedState(this.buffets);

  @override
  List<Object> get props => [buffets];
}

class BuffetLoadingState extends BuffetPageState {
  @override
  List<Object> get props => [];
}
