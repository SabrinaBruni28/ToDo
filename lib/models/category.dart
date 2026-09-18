class Category {
  int id;
  String name;

  Category({this.id = 0, this.name = ""});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'] ?? 0, name: json['name'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
