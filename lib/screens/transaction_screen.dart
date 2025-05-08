import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:expenz/widget/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDismissedIncome;
  const TransactionScreen({
    super.key, 
    required this.expenseList, 
    required this.onDismissedExpense, 
    required this.incomeList, 
    required this.onDismissedIncome});

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
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.expenseList.isEmpty ? const Text("No Expenses added yet, you can add some new expenses",
                      style: TextStyle(
                        fontSize: 16,
                        color: kGrey,
                      ),
                      ) :
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
              SizedBox(height: 10,),
              Text("Incomes ",
              style: TextStyle(
                color: kBlack,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.incomeList.isEmpty ? const  Text("No income added yet, you can add some new incomes",
                      style: TextStyle(
                        fontSize: 16,
                        color: kGrey,
                      ),
                      ) :
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.incomeList.length,
                        itemBuilder:(context, index) {
                        final income = widget.incomeList[index];

                        return Dismissible(
                          key: ValueKey(Income),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            setState(() {
                              widget.onDismissedIncome(income);
                            });
                          },
                          child: IncomeCard(
                            title: income.title, 
                            date: income.date, 
                            amount: income.amount, 
                            category: income.category, 
                            description: income.description, 
                            time: income.time,
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