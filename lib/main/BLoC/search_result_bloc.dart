import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:kinda_work/repository.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultInitial());

  @override
  Stream<SearchResultState> mapEventToState(
    SearchResultEvent event,
  ) async* {
    if (event is SearchResultFetched) {
      yield SearchResultLoadInProgress();
      await Future.delayed(Duration(seconds: 2));
      yield SearchResultLoadSuccess(result: searchResult);
    }
    if (event is SearchResultCleared) {
      yield SearchResultInitial();
    }
  }
}
