import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpenses = [
    /*  Expense(
        amount: 3000,
        date: DateTime.now(),
        title: 'flutter course',
        category: Category.work),
    Expense(
        amount: 3000,
        date: DateTime.now(),
        title: 'flutterhhhh course',
        category: Category.work), */
  ];

  void _openBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(expense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerdExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense, int index) {
    setState(() {
      _registerdExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registerdExpenses.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openBottomSheet,
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: MediaQuery.of(context).size.width < 600
          ? Column(
              children: [
                Center(
                  child: Chart(
                    expenses: _registerdExpenses,
                  ),
                ),
                Expanded(
                  child: _registerdExpenses.isEmpty
                      ? const Center(child: Text('No expenses yet'))
                      : ExpensesList(
                          expenses: _registerdExpenses,
                          removeExpense: _deleteExpense),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registerdExpenses,
                  ),
                ),
                Expanded(
                  child: _registerdExpenses.isEmpty
                      ? const Center(child: Text('No expenses yet'))
                      : ExpensesList(
                          expenses: _registerdExpenses,
                          removeExpense: _deleteExpense),
                ),
              ],
            ),
    );
  }
}
