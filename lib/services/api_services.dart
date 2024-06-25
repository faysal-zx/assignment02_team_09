import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:software_con/model/item.dart';

class ApiService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Item>> getItems() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        print("Fetched data: $jsonResponse");  // Debug print statement
        return jsonResponse.map((item) => Item.fromJson(item)).toList();
      } else {
        print("Failed to load items: ${response.statusCode}");  // Debug print statement
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print("Error fetching data: $e");  // Debug print statement
      throw Exception('Error fetching data');
    }
  }

  Future<Item> createItem(Item item) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  Future<Item> updateItem(Item item) async {
    final response = await http.put(
      Uri.parse("$apiUrl/${item.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }
}