import 'package:first_app/3third_project_wallet/models/expense.dart';
import 'package:first_app/3third_project_wallet/widgets/chart/chart.dart';
import 'package:first_app/3third_project_wallet/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:first_app/3third_project_wallet/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void addNewList(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense newExpense) {
    final expenseIndex = _registeredExpenses.indexOf(newExpense);
    setState(() {
      _registeredExpenses.remove(newExpense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, newExpense);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addNewList: addNewList),
    );
  }

  @override
  Widget build(BuildContext context) {
    // BuildContext는 Flutter의 위젯 트리 내에서 특정 위젯의 위치와 관련된 정보를 제공
    // 세로/ 가로 변경 시에 미디어쿼리 설정!
    // print(MediaQuery.of(context).size.width); // 핸드폰의 넓이를 나타냄 (430.0)
    // print(MediaQuery.of(context).size.height); // 핸드폰의 높이를 나타냄 (932.0)
    // 세로 -> 가로로 핸드폰 방향 변경하면 출력이 된다

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start addming some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600 // 가로 방향일 때는 Row로 바꾸기!
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              // Chart와 Expanded가 동시에 최대한 많은 공간을 차지하려고 하다보니 화면이 보이지 않게 된다 -> Chart에도 Expanded를 적용해야 한다
              // 그렇지 않으면 서로 공간을 차지하려는 충돌이 일어난다.
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
