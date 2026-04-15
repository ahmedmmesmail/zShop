import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zShop/cart_service.dart';
import 'package:zShop/models/CartItem.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartService = CartService();

  double getTotal(List<CartItem> items) {
    return items.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: cartService.items,
        builder: (context, List<CartItem> cartItems, _) {

          if (cartItems.isEmpty) {
            return Center(
              child: Text(
                "Cart is empty 🛒",
                style: GoogleFonts.poppins(fontSize: 18),
              ),
            );
          }

          return Stack(
            children: [

              Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: ListView.builder(
                  itemCount: cartItems.length,
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];

                    return Card(
                      child: ListTile(
                        leading: Image.network(item.image),
                        title: Text(item.title),
                        subtitle: Text("\$${item.price}"),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (item.quantity > 1) {
                                  item.quantity--;
                                  cartService.items.value =
                                      List.from(cartItems);
                                }
                              },
                              icon: const Icon(Icons.remove),
                            ),

                            Text("${item.quantity}"),

                            IconButton(
                              onPressed: () {
                                item.quantity++;
                                cartService.items.value =
                                    List.from(cartItems);
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

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
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
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Total:",
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),

                        Text(
                          "\$${getTotal(cartItems).toStringAsFixed(2)}",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}