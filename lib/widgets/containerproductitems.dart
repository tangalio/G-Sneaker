  import 'package:flutter/material.dart';
  import 'package:shoecartweb/main.dart';
  import 'package:shoecartweb/widgets/productItem.dart';
  import 'package:shoecartweb/theme/themecolors.dart';

  class ContainerProductItems extends StatelessWidget {
    final ShoesData? shoesData;

    const ContainerProductItems({super.key, required this.shoesData});

    @override
    Widget build(BuildContext context) {
      return Container(
        height: 600,
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Màu của shadow
              spreadRadius: 5, // Độ lan rộng của shadow
              blurRadius: 7, // Độ mờ của shadow
              offset: const Offset(0, 3), // Vị trí độ dời của shadow (ngang, dọc)
            ),
          ],
          color: ThemeColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Giới hạn chiều dài của Column
          children: [
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'nike.png',
                    height: 26,
                  ),
                  const SizedBox(
                    child: Text(
                      "Our Products",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (shoesData != null)
              Expanded(
                child: Container(
                  width: 300, // Giới hạn chiều rộng của ListView
                  child: ListView(
                    shrinkWrap: true,
                    children: shoesData!.shoesList
                        .map((shoe) => ProductItem(
                              id: shoe['id'],
                              image: shoe['image'],
                              name: shoe['name'],
                              description: shoe['description'],
                              price: shoe['price'],
                              color: shoe['color'],
                              onAddToCart: () {},
                            ))
                        .toList(),
                  ),
                ),
              )
            else
              const Text(
                "Không có dữ liệu",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      );
    }
  }
