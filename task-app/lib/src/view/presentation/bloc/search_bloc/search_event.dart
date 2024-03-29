part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}


final class SearchReqEvent extends SearchEvent{
  final String search;
  SearchReqEvent(this.search);
}