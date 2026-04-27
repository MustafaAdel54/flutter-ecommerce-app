part of 'favourite_cubit.dart';

sealed class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteActionMessage extends FavouriteIdsLoaded {
  final String message;
  FavouriteActionMessage(this.message, List<int> ids) : super(ids);
}

class FavouriteIdsLoaded extends FavouriteState {
  final List<int> favoriteIds;
  FavouriteIdsLoaded(this.favoriteIds);
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}
