import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var format = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({required this.expense, super.key});
  final void Function(Expense expense) expense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  dynamic _selectedTime;

  _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedTime = pickedDate;
    });
  }

  Expense? newExpense;

  void _saveData() {
    if (_selectedTime == null ||
        double.tryParse(_amountController.text) == null ||
        double.tryParse(_amountController.text)! <= 0 ||
        _titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was enterd'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }

    newExpense = Expense(
        amount: double.tryParse(_amountController.text)!,
        date: _selectedTime,
        title: _titleController.text,
        category: _selectedCategory);
    widget.expense(newExpense!);
    Navigator.pop(context);
  }

  Category _selectedCategory = Category.leisure;

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, keyboard + 16),
        child: SingleChildScrollView(
          child: width >= 600
              ? Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: TextField(
                              controller: _titleController,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                label: Text('Title'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: 'S.P',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: (Category.values.map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ),
                          )).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          },
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text((_selectedTime == null
                                  ? 'No time selected'
                                  : format.format(_selectedTime))),
                              IconButton(
                                onPressed: _datePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _saveData,
                          child: const Text('save Expense'),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(children: [
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: 'S.P',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      //date only
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text((_selectedTime == null
                                ? 'No time selected'
                                : format.format(_selectedTime))),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: (Category.values.map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('cancel'),
                          ),
                          ElevatedButton(
                            onPressed: _saveData,
                            child: const Text('save Expense'),
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
        ),
      );
    });
  }
}
