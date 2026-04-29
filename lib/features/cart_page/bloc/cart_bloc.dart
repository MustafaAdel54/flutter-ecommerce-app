import 'package:bloc/bloc.dart';
import 'package:e_commerce/shared/models/cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;

  CartBloc(this._repository) : super(CartInitial()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final initialItems = await _repository.fetchCartOnce();
        emit(CartLoaded(initialItems));
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });

    on<AddToCartEvent>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final currentItems = Map<String, int>.from(currentState.items);
        final id = event.productId.toString();

        currentItems[id] = (currentItems[id] ?? 0) + 1;

        emit(CartLoaded(currentItems));

        try {
          await _repository.addToCart(event.productId);
          emit(CartActionMessage('Added to Cart'));
          emit(CartLoaded(currentItems));
        } catch (e) {
          add(LoadCartEvent());
          emit(CartError("Failed to add to cart. Please try again."));
        }
      } else {
        try {
          await _repository.addToCart(event.productId);
          add(LoadCartEvent());
        } catch (e) {
          emit(CartError("Failed to add to cart"));
        }
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      if (state is CartLoaded) {
        final currentState = state as CartLoaded;
        final currentItems = Map<String, int>.from(currentState.items);
        final id = event.productId.toString();

        currentItems.remove(id);
        emit(CartLoaded(currentItems));

        try {
          await _repository.removeFromCart(event.productId);
          emit(CartActionMessage('Removed From Cart'));
          emit(CartLoaded(currentItems));
        } catch (e) {
          emit(CartError("Failed to remove item, reverting..."));
          add(LoadCartEvent());
        }
      }
    });

    on<IncreaseCartEvent>((event, emit) async {
      if (state is CartLoaded) {
        final currentItems = Map<String, int>.from((state as CartLoaded).items);
        final id = event.productId.toString();

        currentItems[id] = (currentItems[id] ?? 0) + 1;
        emit(CartLoaded(currentItems));

        _repository.increaseInCart(event.productId).catchError((e) {
          add(LoadCartEvent());
        });
      }
    });

    on<DecreaseCartEvent>((event, emit) async {
      if (state is CartLoaded) {
        final currentItems = Map<String, int>.from((state as CartLoaded).items);
        final id = event.productId.toString();
        final currentQty = currentItems[id] ?? 0;

        if (currentQty > 1) {
          currentItems[id] = currentQty - 1;
          emit(CartLoaded(currentItems));

          _repository.decreaseFromCart(event.productId).catchError((e) {
            add(LoadCartEvent());
          });
        }
      }
    });
    on<ClearCartEvent>((event, emit) async {
      emit(CartLoaded(const {}));
      try {
        await _repository.clearCart();
      } catch (e) {
        add(LoadCartEvent());
      }
    });

    add(LoadCartEvent());
  }
}
