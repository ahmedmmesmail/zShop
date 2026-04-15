import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zShop/product.dart';

class CategoryPage extends StatefulWidget {
  final String categoryKey;
  final String title;

  const CategoryPage({
    super.key,
    required this.categoryKey,
    required this.title,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://dummyjson.com/products/category/${widget.categoryKey}',
        ),
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
      print("ERROR: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFDE5E5E),
        iconTheme: const IconThemeData(
          color: Colors.white,
        )
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 5),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text("\$${product.price}"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}