import 'dart:async';

import 'package:e_commerce/shared/models/favourite_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final FavouriteRepository _repository;
  StreamSubscription? _subscription;

  FavouriteCubit(this._repository) : super(FavouriteInitial());

  void loadFavourites() {
    emit(FavouriteLoading());
    _subscription = _repository.getFavoriteIds().listen(
      (ids) {
        emit(FavouriteIdsLoaded(ids));
      },
      onError: (e) {
        emit(FavouriteError(e.toString()));
      },
    );
  }

  Future<void> toggleFavorite(int productId) async {
    try {
      final isAdded = await _repository.toggleFavorite(productId);

      final currentIds = (state is FavouriteIdsLoaded)
          ? (state as FavouriteIdsLoaded).favoriteIds
          : <int>[];

      emit(
        FavouriteActionMessage(
          isAdded ? 'Added to favourites' : 'Removed from favourites',
          currentIds,
        ),
      );
    } catch (e) {
      emit(FavouriteError("Could not update favorites"));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
