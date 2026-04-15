import 'package:flutter/material.dart';
import 'package:zShop/models/CartItem.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() => _instance;

  CartService._internal();

  ValueNotifier<List<CartItem>> items = ValueNotifier([]);

  void addToCart(CartItem item) {
    final list = items.value;

    for (var i in list) {
      if (i.title == item.title) {
        i.quantity += item.quantity;
        items.value = List.from(list);
        return;
      }
    }

    list.add(item);
    items.value = List.from(list);
  }

  void clear() {
    items.value = [];
  }
}