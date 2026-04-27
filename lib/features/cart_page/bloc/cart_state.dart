part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final Map<String, int> items;
  CartLoaded(this.items);
}

class CartActionMessage extends CartState {
  final String message;
  CartActionMessage(this.message);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
