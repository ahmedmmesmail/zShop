import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zShop/CartPage.dart';
import 'package:zShop/CategoryPage.dart';
import 'package:zShop/HomeContent.dart';

import 'package:zShop/product.dart';
import 'package:zShop/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  bool isLoading = true;

  final List<Category> categories = [
    Category(
      name: "Smartphones",
      key: "smartphones",
      icon: Icons.phone_iphone,
      color: Colors.red,
    ),
    Category(
      name: "Laptops",
      key: "laptops",
      icon: Icons.laptop_mac,
      color: Colors.orange,
    ),
    Category(
      name: "Fragrances",
      key: "fragrances",
      icon: Icons.spa,
      color: Colors.pink,
    ),
    Category(
      name: "Skincare",
      key: "beauty",
      icon: Icons.face_retouching_natural,
      color: Colors.blue,
    ),
    Category(
      name: "Groceries",
      key: "groceries",
      icon: Icons.local_grocery_store,
      color: Colors.lightGreen,
    ),
    Category(
      name: "Furniture",
      key: "furniture",
      icon: Icons.chair,
      color: Colors.brown,
    ),
    Category(
      name: "Womens Dresses",
      key: "womens-dresses",
      icon: Icons.checkroom,
      color: Colors.purple,
    ),
    Category(
      name: "Womens Shoes",
      key: "womens-shoes",
      icon: Icons.directions_walk,
      color: Colors.blueGrey,
    ),
    Category(
      name: "Mens Shirts",
      key: "mens-shirts",
      icon: Icons.emoji_people,
      color: Colors.indigo,
    ),
    Category(
      name: "Mens Shoes",
      key: "mens-shoes",
      icon: Icons.directions_run,
      color: Colors.lime,
    ),
    Category(
      name: "Tops",
      key: "tops",
      icon: Icons.checkroom_outlined,
      color: Colors.cyan,
    ),
    Category(
      name: "Motorcycle",
      key: "motorcycle",
      icon: Icons.two_wheeler,
      color: Colors.deepOrange,
    ),
    Category(
      name: "Home Decoration",
      key: "home-decoration",
      icon: Icons.home,
      color: Colors.amber,
    ),
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/products'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List list = data['products'];

        setState(() {
          products = list.map((e) => Product.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'zShop',
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Color(0xFFDE5E5E),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              // بعد تسجيل الخروج ارجع لشاشة login
              Navigator.pushReplacementNamed(context, '/login');
            },

          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeContent(
            isLoading: isLoading,
            products: products,
            categories: categories,
          ),
          CartPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF5E5E5E),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFFDE5E5E),
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_rounded),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}

