class Category {
  int id;
  String name;

  Category({required this.id, required this.name});

  factory Category.makeitem(Map<String, dynamic> object) {
    return Category(
      id: object['id'],
      name: object['name'],
    );
  }
}
