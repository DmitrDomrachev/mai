part of 'creative_page_cubit.dart';

abstract class CreativePageState extends Equatable {
  const CreativePageState();
}

class CreativePageLoadingState extends CreativePageState {
  @override
  List<Object> get props => [];
}

class CreativePageLoadedState extends CreativePageState {
  final List<CreativeOrganizations> organizations;

  const CreativePageLoadedState(this.organizations);

  @override
  List<Object> get props => [organizations];
}
