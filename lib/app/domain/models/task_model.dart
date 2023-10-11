import 'dart:convert';

class TaskModel {
  int? id;
  String title;
  String description;
  bool done;
  String priority;
  String creationDate;
  Images? images;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.done,
    required this.priority,
    required this.creationDate,
    required this.images,
  });

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        done: json["done"] == 1 ? true : false,
        priority: json["priority"],
        creationDate: json["creationDate"],
        // images: Images.fromMap(json["images"]),
        images: null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "done": done ? 1 : 0,
        "priority": priority,
        "creationDate": creationDate,
        // "images": images != null ? images!.toMap() : null,
      };
}

class Images {
  String uri1;
  String uri2;
  String uri3;

  Images({
    required this.uri1,
    required this.uri2,
    required this.uri3,
  });

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        uri1: json["uri1"],
        uri2: json["uri2"],
        uri3: json["uri3"],
      );

  Map<String, dynamic> toMap() => {
        "uri1": uri1,
        "uri2": uri2,
        "uri3": uri3,
      };
}
