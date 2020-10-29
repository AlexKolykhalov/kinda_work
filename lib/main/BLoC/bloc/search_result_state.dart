part of 'search_result_bloc.dart';

@immutable
abstract class SearchResultState {}

class SearchResultInitial extends SearchResultState {}

class SearchResultLoadInProgress extends SearchResultState {}

class SearchResultLoadSuccess extends SearchResultState {
  SearchResultLoadSuccess({@required this.result});

  final Map result;
}

class SearchResultLoadFailure extends SearchResultState {}
