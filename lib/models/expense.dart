import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
var format = DateFormat.yMd();

enum Category { food, work, travel, leisure }

var categortIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense(
      {required this.amount,
      required this.date,
      required this.title,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return format.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.expenses,
    required this.category,
  });

  ExpenseBucket.forCategort(List<Expense> allExpense, this.category)
      : expenses = (allExpense
            .where((expense) => expense.category == category)
            .toList());

  final List<Expense> expenses;
  final Category category;

  double get totalExpense {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
