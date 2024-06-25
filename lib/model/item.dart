class Item {
  final int id;
  final String title;  // Ensure this matches the API response
  final String body;   // Ensure this matches the API response

  Item({required this.id, required this.title, required this.body});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',  // Ensure this matches the API response
      body: json['body'] ?? '',    // Ensure this matches the API response
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
