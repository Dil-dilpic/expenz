import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/onboarding/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:expenz/widget/income_expense_card.dart';
import 'package:expenz/widget/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final List<Income> incomeList;
  const HomeScreen({
    super.key, 
    required this.expenseList, 
    required this.incomeList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String username = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    // get the username from shared pref
    UserServices.getUserData().then((value){
      if (value["userName"] != null) {
        setState(() {
           username = value['userName']!;
        });
      }
    });
    setState(() {

      // Toatl amount of expenses
      for (var i = 0; i < widget.expenseList.length; i++) {
        expenseTotal += widget.expenseList[i].amount;
      }

      // Total amount of incomes
      for (var k = 0; k < widget.incomeList.length; k++) {
        incomeTotal += widget.incomeList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        // main column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // bg colored column
            Container(
              height: MediaQuery.of(context).size.height*0.35,
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.35),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: kMainColor,
                            border: Border.all(
                              color: kMainColor,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "asset/images/user.jpg",
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Welcome $username",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: kMainColor,
                          size: 30,
                        ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncomeExpenseCard(
                          title: "Income", 
                          amount: incomeTotal, 
                          imageUrl: "asset/images/income.png", 
                          bgColor: kGreen),
                        IncomeExpenseCard(
                          title: "Expense", 
                          amount: expenseTotal, 
                          imageUrl: "asset/images/expense.png", 
                          bgColor: kRed),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //line chart
            const Padding(
              padding: EdgeInsets.all(
                kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Spend Frequency",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    LineChartSample(),
                  ],
                ),
                ),
                //recent tranceactions
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Recent transActions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          widget.expenseList.isEmpty ? const  Text("No Expenses added yet, you can add some new expenses",
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

                        return ExpenseCard(
                          title: expense.title, 
                          date: expense.date, 
                          amount: expense.amount, 
                          category: expense.category, 
                          description: expense.description, 
                          time: expense.time,
                          );
                      },)
                        ],
                      )
                    ],
                  ),
                  ),
          ],
        ),
      ),
      ),
    );
  }
}