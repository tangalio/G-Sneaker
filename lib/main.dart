import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shoecartweb/widgets/containercartyouritems.dart';
import './theme/themecolors.dart';
import './widgets/productItem.dart';
import 'model/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Golden Sneaker',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: const MyHomePage(
          title: 'Golden Sneaker',
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ShoesData? _shoesData;
  List<Product> addedToCartProducts = [];
  @override
  void initState() {
    super.initState();
    loadShoesData().then((data) {
      setState(() {
        _shoesData = data;
      });
    });
  }

  void _handleProductAddedToCart(String productName) {
    print("Added to cart: $productName");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 600,
                  width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Màu của shadow
                        spreadRadius: 5, // Độ lan rộng của shadow
                        blurRadius: 7, // Độ mờ của shadow
                        offset: const Offset(
                            0, 3), // Vị trí độ dời của shadow (ngang, dọc)
                      ),
                    ],
                    color: ThemeColors.white,
                  ),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Giới hạn chiều dài của Column
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
                      if (_shoesData != null)
                        Expanded(
                          child: Container(
                            width: 300, // Giới hạn chiều rộng của ListView
                            child: ListView(
                              shrinkWrap: true,
                              children: _shoesData!.shoesList
                                  .map((shoe) => ProductItem(
                                        id: shoe['id'],
                                        image: shoe['image'],
                                        name: shoe['name'],
                                        description: shoe['description'],
                                        price: shoe['price'],
                                        color: shoe['color'],
                                        onAddToCart: _handleProductAddedToCart,
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
                ),
                const SizedBox(width: 40),
                const ContainerCartYourItems(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShoesData {
  final List<dynamic> shoesList;

  ShoesData(this.shoesList);

  factory ShoesData.fromJson(Map<String, dynamic> json) {
    return ShoesData(json['shoes'] as List);
  }
}

Future<ShoesData> loadShoesData() async {
  final jsonString = await rootBundle.loadString('data/shoes.json');
  final jsonResponse = json.decode(jsonString);
  return ShoesData.fromJson(jsonResponse);
}
