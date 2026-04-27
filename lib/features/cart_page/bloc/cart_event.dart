part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final int productId;
  AddToCartEvent(this.productId);
}

class IncreaseCartEvent extends CartEvent {
  final int productId;
  IncreaseCartEvent(this.productId);
}

class DecreaseCartEvent extends CartEvent {
  final int productId;
  DecreaseCartEvent(this.productId);
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;
  RemoveFromCartEvent(this.productId);
}
