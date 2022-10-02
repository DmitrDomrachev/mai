part of 'organizations_page_cubit.dart';

abstract class OrganizationsPageState extends Equatable {
  const OrganizationsPageState();
}

class OrganizationsPageLoadingState extends OrganizationsPageState {
  @override
  List<Object> get props => [];
}

class OrganizationsPageLoadedState extends OrganizationsPageState {
  final List<StudentOrganization> organizations;

  const OrganizationsPageLoadedState(this.organizations);

  @override
  List<Object> get props => [organizations];
}
