import 'package:client/models/department_model.dart';

class Class {
  String? id;
  String name;
  int numberOfStudents;
  Department? departmentSpace;

  Class({
    this.id,
    required this.name,
    required this.numberOfStudents,
    required this.departmentSpace,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      numberOfStudents: json['numberOfStudents'],
      departmentSpace: Department.fromJson(json['departmentSpace']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'numberOfStudents': numberOfStudents,
      'departmentSpace': departmentSpace?.toJson(),
    };
  }
}
