class Item {
  final String title;
  final String description;
  final int price;
  final String img_name;
  final int id;

  Item({
    required this.title,
    required this.description,
    required this.price,
    required this.img_name,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      img_name: json['img_name'],
      id: json['id'],
    );
  }
}
