import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zShop/CategoryPage.dart';
import 'package:zShop/category.dart';
import 'package:zShop/product.dart';

class HomeContent extends StatelessWidget {
  final bool isLoading;
  final List<Product> products;
  final List<Category> categories;

  const HomeContent({
    super.key,
    required this.isLoading,
    required this.products,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Categories Title
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
                const Icon(Icons.arrow_forward_ios_rounded),
              ],
            ),

            const SizedBox(height: 10),

            /// Categories List
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

            /// Products Title
            Text(
              "Featured products",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            /// Grid
            GridView.builder(
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
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
      ),
    );
  }
}