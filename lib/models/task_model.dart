import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  /// [id] of the task
  String? id;

  /// [Title] of the task
  final String title;

  /// [finalAmount] to be saved
  final double finalAmount;

  /// [currentAmount] saved so far
  double currentAmount;

  /// [createdAt] date of creation of the task
  final DateTime createdAt;

  /// [deadline] date of deadline of the task
  final DateTime deadline;

  /// [uid] of the user who created the task
  final String createdBy;
  Task({
    required this.title,
    required this.finalAmount,
    required this.currentAmount,
    required this.createdAt,
    required this.deadline,
    required this.createdBy,
    this.id,
  });

  Task copyWith({
    String? title,
    double? finalAmount,
    double? currentAmount,
    DateTime? createdAt,
    DateTime? deadline,
    String? createdBy,
  }) {
    return Task(
      title: title ?? this.title,
      finalAmount: finalAmount ?? this.finalAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'finalAmount': finalAmount,
      'currentAmount': currentAmount,
      'createdAt': Timestamp.fromDate(createdAt),
      'deadline': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      finalAmount: (map['finalAmount'] as num).toDouble(),
      currentAmount: (map['currentAmount'] as num).toDouble(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      deadline: (map['deadline'] as Timestamp).toDate(),
      createdBy: map['createdBy'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(title: $title, finalAmount: $finalAmount, currentAmount: $currentAmount, createdAt: $createdAt, deadline: $deadline), createdBy: $createdBy';
  }
}
