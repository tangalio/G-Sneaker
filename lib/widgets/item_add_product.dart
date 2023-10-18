import 'package:flutter/material.dart';

class ItemAddProduct extends StatelessWidget {
  final int id;
  final String image;
  final String name;
  final double price;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const ItemAddProduct({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(image,
            width: 100, height: 100), // Thay đổi kích thước theo ý muốn
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('\$${price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14)),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: onDecrease,
            ),
            Text(quantity.toString()), // Hiển thị số lượng
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onIncrease,
            ),
            IconButton(
              icon:
                  Image.asset('assets/trash.png'), // Sử dụng hình ảnh trash.png
              onPressed: onRemove,
            ),
          ],
        ),
      ],
    );
  }
}
