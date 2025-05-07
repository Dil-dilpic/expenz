import 'package:expenz/models/expense_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final void Function(Expense) onDismissedExpense;
  const TransactionScreen({
    super.key, 
    required this.expenseList, 
    required this.onDismissedExpense});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("See your financial report",
              style: TextStyle(
                color: kMainColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Expenses ",
              style: TextStyle(
                color: kBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              ),
              SizedBox(
                height: 20,
              ),
              //show all the expenses
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.expenseList.length,
                        itemBuilder:(context, index) {
                        final expense = widget.expenseList[index];

                        return Dismissible(
                          key: ValueKey(expense),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              widget.onDismissedExpense(expense);
                            });
                          },
                          child: ExpenseCard(
                            title: expense.title, 
                            date: expense.date, 
                            amount: expense.amount, 
                            category: expense.category, 
                            description: expense.description, 
                            time: expense.time,
                            ),
                        );
                      },)
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),
          ),
    );
  }
}