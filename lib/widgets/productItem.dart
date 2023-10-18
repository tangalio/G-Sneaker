import 'package:flutter/material.dart';
import 'package:shoecartweb/theme/themecolors.dart';

class ProductItem extends StatefulWidget {
  final int id;
  final String image;
  final String name;
  final String description;
  final double price;
  final String color;
  final Function(String) onAddToCart;

  const ProductItem({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool addedToCart = false; // Trạng thái đã thêm vào giỏ hàng

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(30), // BorderRadius cho hình ảnh
            color: Color(int.parse(widget.color.replaceAll('#', '0xFF'))),
          ),
          child: Image.network(widget.image),
        ),
        Text(
          widget.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(widget.description,
            style: const TextStyle(fontSize: 14, color: ThemeColors.gray)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${widget.price}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            addedToCart
                ? Image.asset('check.png',
                    height: 20,
                    width:
                        20) // Hiển thị hình ảnh check.png khi đã thêm vào giỏ hàng
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        addedToCart = true;
                        // Đã thêm vào giỏ hàng
                        onAddToCart(widget.name);
                      });
                    },
                    child: const Text('Add to Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ThemeColors.black)),
                  ),
          ],
        ),
        const SizedBox(height: 30), // Khoảng cách giữa các sản phẩm
      ],
    );
  }
}
