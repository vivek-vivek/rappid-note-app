// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) =>
    List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  String? title;
  String? description;
  String? date;
  String? id;

  Task({
    this.title,
    this.description,
    this.date,
    this.id,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"],
        description: json["description"],
        date: json["date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date": date,
        "id": id,
      };
}
