class Item {
  String title;
  bool done;

  Item({this.title = "", this.done = false});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(title: json['title'], done: json['done']);
  }

  Map<String, dynamic> toJson() {
    final mapString = <String, dynamic>{};

    mapString['title'] = title;
    mapString['done'] = done;

    return mapString;
  }
}
