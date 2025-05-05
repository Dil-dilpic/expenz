import 'package:expenz/screens/onboarding/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/income_expense_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for store the username
  String username = "";

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        // main column
        child: Column(
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
                          amount: 1200, 
                          imageUrl: "asset/images/income.png", 
                          bgColor: kGreen),
                        IncomeExpenseCard(
                          title: "Expense", 
                          amount: 800, 
                          imageUrl: "asset/images/expense.png", 
                          bgColor: kRed),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}