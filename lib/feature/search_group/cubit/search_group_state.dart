part of 'search_group_cubit.dart';

abstract class SearchGroupState extends Equatable {
  const SearchGroupState();
}

class SearchGroupInitial extends SearchGroupState {
  final String searchText;
  final List<Group> searchResult;

  const SearchGroupInitial({
    this.searchText = '',
    this.searchResult = const [],
  });

  @override
  List<Object> get props => [
        searchText,
        searchResult,
      ];

  SearchGroupInitial copyWith({
    String? searchText,
    List<Group>? searchResult,
  }) {
    return SearchGroupInitial(
      searchText: searchText ?? this.searchText,
      searchResult: searchResult ?? this.searchResult,
    );
  }
}

class SearchGroupDone extends SearchGroupState {
  @override
  List<Object?> get props => [];

}