import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zShop/models/CartItem.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Dummy data للتصميم
  List<CartItem> cartItems = [
    CartItem(
      title: "iPhone 14 Pro",
      image: "https://i.dummyjson.com/data/products/1/thumbnail.jpg",
      price: 999,
    ),
    CartItem(
      title: "MacBook Pro",
      image: "https://i.dummyjson.com/data/products/6/thumbnail.png",
      price: 1999,
    ),
  ];

  double get totalPrice {
    return cartItems.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cartItems.isEmpty
          ?  Center(
        child: Text(
            "Cart is empty 🛒",
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),

                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),

                    title: Text(
                      item.title,
                      style: GoogleFonts.poppins(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text(
                      "\$${item.price}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.green),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (item.quantity > 1) {
                                item.quantity--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),

                        Text(
                          "${item.quantity}",
                          style: GoogleFonts.poppins(),
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              item.quantity++;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// Bottom Summary
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: GoogleFonts.poppins(fontSize: 18),
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDE5E5E),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Checkout",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}