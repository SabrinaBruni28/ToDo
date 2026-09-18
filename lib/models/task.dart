class Task {
  int id;
  String title;
  String description;
  bool done;

  // Construtor
  Task({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.done = false,
  });

  // Transforma um JSON na classe
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      done: json['done'],
    );
  }

  // Transforma a classe em um JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description, 'done': done};
  }
}
