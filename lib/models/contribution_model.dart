// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Contribution {
  /// [id] of the task
  final String task;

  /// [name] of the contribution
  final String name;

  /// [amount] of the contribution
  final double amount;

  /// [contributedAt] date & time of contribution
  final DateTime contributedAt;

  /// [id] of the contribution
  String? id;
  Contribution({
    required this.task,
    required this.name,
    required this.amount,
    required this.contributedAt,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'name': name,
      'amount': amount,
      'contributedAt': Timestamp.fromDate(contributedAt),
    };
  }

  factory Contribution.fromMap(Map<String, dynamic> map) {
    return Contribution(
      task: map['task'] as String,
      name: map['name'] as String,
      amount: (map['amount'] as num).toDouble(),
      contributedAt: (map['contributedAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Contribution.fromJson(String source) =>
      Contribution.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Contribution(task: $task, name: $name, amount: $amount, contributedAt: $contributedAt)';
  }

  @override
  bool operator ==(covariant Contribution other) {
    if (identical(this, other)) return true;

    return other.task == task &&
        other.name == name &&
        other.amount == amount &&
        other.contributedAt == contributedAt;
  }

  @override
  int get hashCode {
    return task.hashCode ^
        name.hashCode ^
        amount.hashCode ^
        contributedAt.hashCode;
  }
}
