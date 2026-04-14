import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zShop/CategoryPage.dart';

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
            icon: Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 18),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Categories",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final cat = categories[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryPage(
                                    categoryKey: cat.key,
                                    title: cat.name,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: CircleAvatar(
                                radius: 28,
                                backgroundColor: cat.color.withOpacity(0.2),
                                child: Icon(cat.icon, color: cat.color),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Featured products",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.7,
                            ),
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 5),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      product.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "\$${product.price}",
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
