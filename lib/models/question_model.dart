// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuestionModel {
  final String id;
  final String title;
  final Map<String, bool> options;

  QuestionModel({required this.id, required this.title, required this.options});

  @override
  String toString() {
    return 'QuestionModel{id: $id, question: $title, options: $options}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'options': options,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
        id: map['id'] as String,
        title: map['title'] as String,
        options: (map['options'] as Map<String, dynamic>).map((key, value) {
          if (value is bool) {
            return MapEntry(key, value);
          } else {
            return MapEntry(key, false); // Default to false if not bool
          }
        }));
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
