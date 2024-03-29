part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class LoadingSearchState extends SearchState {}
final class SuccessSearchState extends SearchState {
  final List<TaskModel?>? searchTaskModels;
  SuccessSearchState(this.searchTaskModels);
}
final class FailSearchState extends SearchState {
  final String error;
  FailSearchState(this.error);
}
