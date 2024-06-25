import 'package:flutter/material.dart';
import 'package:software_con/model/item.dart';
import 'package:software_con/services/api_services.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];
  final ApiService _apiService = ApiService();

  List<Item> get items => _items;

  Future<void> fetchItems() async {
    try {
      _items = await _apiService.getItems();
      print("Items fetched: ${_items.length}");  // Debug print statement
      notifyListeners();
    } catch (e) {
      print("Error fetching items: $e");  // Debug print statement
    }
  }

  Future<void> addItem(Item item) async {
    try {
      Item newItem = await _apiService.createItem(item);
      _items.add(newItem);
      notifyListeners();
    } catch (e) {
      print("Error adding item: $e");  // Debug print statement
    }
  }

  Future<void> updateItem(Item item) async {
    try {
      Item updatedItem = await _apiService.updateItem(item);
      int index = _items.indexWhere((i) => i.id == item.id);
      _items[index] = updatedItem;
      notifyListeners();
    } catch (e) {
      print("Error updating item: $e");  // Debug print statement
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await _apiService.deleteItem(id);
      _items.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      print("Error deleting item: $e");  // Debug print statement
    }
  }
}