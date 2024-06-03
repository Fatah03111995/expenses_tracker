import 'package:flutter/material.dart';

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

Map<Category, Color> categoryColor = {
  Category.baby: Colors.blue,
  Category.food: Colors.orange,
  Category.leisure: Colors.lightGreen,
  Category.others: Colors.purple,
  Category.work: Colors.indigo
};

Map<Category, IconData> categoryIcon = {
  Category.baby: Icons.child_care,
  Category.food: Icons.restaurant,
  Category.leisure: Icons.hiking,
  Category.others: Icons.paid,
  Category.work: Icons.business_center
};
