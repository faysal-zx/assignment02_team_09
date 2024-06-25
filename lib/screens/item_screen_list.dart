import 'package:flutter/material.dart';
import 'package:software_con/model/item.dart';
import 'package:software_con/providers/items_providers.dart';
import 'package:software_con/screens/item_form_screen.dart';
import 'package:provider/provider.dart';


class ItemListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ItemFormScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(context, listen: false).fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                if (itemProvider.items.isEmpty) {
                  return Center(child: Text('No items found.'));
                }
                return ListView.builder(
                  itemCount: itemProvider.items.length,
                  itemBuilder: (context, index) {
                    Item item = itemProvider.items[index];
                    print("Displaying item: ${item.title}");  // Debug print statement
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ListTile(
                        title: Text(
                          item.title,  // Display the title
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(item.body),  // Display the body
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemFormScreen(item: item),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                Provider.of<ItemProvider>(context, listen: false).deleteItem(item.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}