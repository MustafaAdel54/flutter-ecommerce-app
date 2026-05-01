import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? id;
  final String title;
  final double price;
  final String description;
  final String image;

  const ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> imagesList = map['images'] ?? [];
    return ProductModel(
      id: map['id'],
      title: map['title'] ?? '',
      price: (map['price'] is num) ? (map['price'] as num).toDouble() : 0.0,
      description: map['description'] ?? '',
      image: imagesList.isNotEmpty ? imagesList.first.toString() : '',
    );
  }

  @override
  List<Object?> get props => [id];
}
