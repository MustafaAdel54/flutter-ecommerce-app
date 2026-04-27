part of 'market_cubit.dart';

sealed class MarketState {}

final class MarketInitial extends MarketState {}

final class MarketLoading extends MarketState {}

final class MarketSuccess extends MarketState {
  final List<ProductModel> products;
  MarketSuccess(this.products);
}

final class MarketError extends MarketState {
  final String message;
  MarketError(this.message);
}
