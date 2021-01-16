abstract class SearchStates{}
class SearchInitial extends SearchStates{}
class SearchLoading extends SearchStates{}
class SearchLoadingMore extends SearchStates{}
class SearchSuccess extends SearchStates{}
class SearchError extends SearchStates{
  final error;
  SearchError(this.error);
}