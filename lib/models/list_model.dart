import 'package:get/get.dart';

class Todo extends GetxController {
  String title;
  String username;
  String pw;
  String note;
  bool show;

  Todo(
      {required this.title,
      required this.username,
      required this.pw,
      required this.note,
      required this.show});

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
      title: json['title'],
      username: json['username'],
      pw: json['pw'],
      note: json['note'],
      show: json['show']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'username': username,
        'pw': pw,
        'note': note,
        'show': show
      };
}
