import 'package:e_commerce/features/cart_page/bloc/cart_bloc.dart';
import 'package:e_commerce/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSuccessDialog extends StatefulWidget {
  const OrderSuccessDialog({super.key});

  @override
  State<OrderSuccessDialog> createState() => _OrderSuccessDialogState();
}

class _OrderSuccessDialogState extends State<OrderSuccessDialog> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startLoadingTimer();
  }

  void _startLoadingTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: _isLoading
                ? _buildLoadingState()
                : _buildSuccessState(context),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      key: ValueKey('LoadingState'),
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: Color(0xFF0F2043)),
          SizedBox(height: 24),
          Text(
            'Processing Order...',
            style: TextStyle(
              color: Color(0xFF0F2043),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return Column(
      key: const ValueKey('SuccessState'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF8DE8DF), // Teal/cyan background from the image
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Color(0xFF0F2043), // Dark blue
            size: 32,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Order Placed Successfully',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF0F2043),
            fontSize: 22,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Your curated items are being prepared for dispatch. You will receive a confirmation email shortly.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 32),
        PrimaryButton(
          text: 'Continue',
          onPressed: () {
            context.read<CartBloc>().add(ClearCartEvent());
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
