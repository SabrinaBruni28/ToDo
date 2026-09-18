// Claase que representa uma tarefa
class Task {
  String title;
  String description;
  bool done;

  // Construtor
  Task({this.title = "", this.done = false, this.description = ""});

  // Transforma um json na classe
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      done: json['done'],
      description: json['description'],
    );
  }

  // Transforma a classe em um json
  Map<String, dynamic> toJson() {
    final mapString = <String, dynamic>{};

    mapString['title'] = title;
    mapString['done'] = done;
    mapString['description'] = description;

    return mapString;
  }
}
