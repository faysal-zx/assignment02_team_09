import 'package:flutter/material.dart';
import 'package:software_con/model/item.dart';
import 'package:software_con/providers/items_providers.dart';
import 'package:provider/provider.dart';


class ItemFormScreen extends StatefulWidget {
  final Item? item;

  ItemFormScreen({this.item});

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _body;

  @override
  void initState() {
    super.initState();
    _title = widget.item?.title ?? '';
    _body = widget.item?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value ?? '';
                },
              ),
              TextFormField(
                initialValue: _body,
                decoration: InputDecoration(labelText: 'Body'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a body';
                  }
                  return null;
                },
                onSaved: (value) {
                  _body = value ?? '';
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.item == null) {
                      Provider.of<ItemProvider>(context, listen: false).addItem(
                        Item(id: 0, title: _title, body: _body),
                      );
                    } else {
                      Provider.of<ItemProvider>(context, listen: false).updateItem(
                        Item(id: widget.item!.id, title: _title, body: _body),
                      );
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}