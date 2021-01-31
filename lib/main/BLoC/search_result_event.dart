part of 'search_result_bloc.dart';

@immutable
abstract class SearchResultEvent {}

class SearchResultFetched extends SearchResultEvent {
  SearchResultFetched({@required this.searchText});

  final String searchText;
}

class SearchResultCleared extends SearchResultEvent {}
