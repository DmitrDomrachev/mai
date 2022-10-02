part of 'library_page_cubit.dart';

abstract class LibraryPageState extends Equatable {
  const LibraryPageState();
}

class LibraryPageLoadedState extends LibraryPageState {
  final List<Library> libraries;

  const LibraryPageLoadedState(this.libraries);

  @override
  List<Object> get props => [libraries];
}

class LibraryLoadingState extends LibraryPageState {
  @override
  List<Object> get props => [];
}
