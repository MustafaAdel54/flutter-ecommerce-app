import 'package:e_commerce/features/market_page/cubit/market/market_cubit.dart';
import 'package:e_commerce/shared/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InputField(
        controller: _controller,
        hintText: 'Search collection...',
        icon: const Icon(Icons.search, color: Colors.grey),
        onChanged: (value) {
          context.read<MarketCubit>().searchProducts(value);
        },
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (context, value, child) {
            if (value.text.isEmpty) {
              return const SizedBox.shrink();
            }
            return IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                _controller.clear();
                context.read<MarketCubit>().searchProducts('');
                FocusScope.of(context).unfocus();
              },
            );
          },
        ),
      ),
    );
  }
}
