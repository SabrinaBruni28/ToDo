class Item {
  String title;
  String descricao;
  bool done;

  Item({this.title = "", this.done = false, this.descricao = ""});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      done: json['done'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    final mapString = <String, dynamic>{};

    mapString['title'] = title;
    mapString['done'] = done;
    mapString['descricao'] = descricao;

    return mapString;
  }
}
