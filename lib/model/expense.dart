// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Category { work, food, leisure, baby, others }

Map<Category, String> categoryToString = {
  Category.baby: 'baby',
  Category.food: 'food',
  Category.leisure: 'leisure',
  Category.others: 'others',
  Category.work: 'work',
};

Map<String, Category> stringToCategory = {
  'baby': Category.baby,
  'food': Category.food,
  'leisure': Category.leisure,
  'others': Category.others,
  'work': Category.work,
};

class Expense {
  final String? id;
  final DateTime createdAt;
  String title;
  double amount;
  DateTime editedAt;
  Category category;

  Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.createdAt,
      required this.editedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'title': title,
      'amount': amount,
      'editedAt': editedAt.millisecondsSinceEpoch,
      'category': categoryToString[category],
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] != null ? map['id'] as String : null,
      createdAt:
          map['date'].fromMillisecondsSinceEpoch(map['createdAt'] as int),
      title: map['title'] as String,
      amount: map['amount'] as double,
      editedAt: DateTime.fromMillisecondsSinceEpoch(map['editedAt'] as int),
      category: stringToCategory[map['category']]!,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);
}
