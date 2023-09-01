import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense, int index) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            margin: Theme.of(context).cardTheme.margin,
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          removeExpense(expenses[index], index);
        },
        child: ExpensesItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
