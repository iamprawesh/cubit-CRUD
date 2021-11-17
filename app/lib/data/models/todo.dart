// // To parse this JSON data, do
// //
// //     final todo = todoFromJson(jsonString);

// import 'dart:convert';

// List<Todo> todoFromJson(String str) =>
//     List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

// String todoToJson(List<Todo> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    this.todo,
    this.isCompleted,
    this.id,
  });

  String? todo;
  String? isCompleted;
  int? id;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        todo: json["todo"],
        isCompleted: json["isCompleted"],
        id: json["id"] as int,
      );

  Map<String, dynamic> toJson() => {
        "todo": todo,
        "isCompleted": isCompleted,
        "id": id,
      };
}

// class PostAPI {
//   final int? userId;
//   final int? id;
//   final String? title;
//   final String? body;

//   PostAPI({this.userId, this.id, this.title, this.body});

//   factory PostAPI.fromJson(Map<String, dynamic> json) => PostAPI(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body']);
// }
