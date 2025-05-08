import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/category_card.dart';
import 'package:expenz/widget/pie_chart.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  final Map<Expensecategory, double> expenseCategorytotals;
  final Map<IncomeCategory, double> incomeCategorytotals;
  const BudgetScreen({
    super.key, 
    required this.expenseCategorytotals, 
    required this.incomeCategorytotals});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedOption = 0;

  //methode to find the category color from the category 
  Color getCategoryColor ( dynamic category) {

    if (category is Expensecategory) {
      return expenseCategoriesColors[category]!;
    }else {
      return incomeCategoryColor[category]!;
    }
  }
  @override
  Widget build(BuildContext context) {

    final data = _selectedOption == 0 ? widget.expenseCategorytotals : widget.incomeCategorytotals;
    return Scaffold(
     appBar: AppBar(
      title: const Text(
        "Financial Report",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: kBlack,
        ),
      ),
      centerTitle: true,
     ),
     body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: kDefaultPadding / 2,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height*0.06,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: kBlack.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedOption = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: _selectedOption == 1 ? kWhite : kRed,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 50,
                          ),
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              color:_selectedOption == 0 ? kWhite : kBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          ),
                      ),
                    ),
                    GestureDetector(
                       onTap: () {
                        setState(() {
                          _selectedOption = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: _selectedOption == 0 ? kWhite : kGreen,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 50,
                          ),
                          child: Text(
                            "Income",
                            style: TextStyle(
                              color: _selectedOption == 1 ? kWhite : kBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          ),
                      ),
                    )
                  ],
                ),
              ),
              ),
              const SizedBox(
                height: 20,
              ),
              //pie chart implement
              Chart(
                expenseCategorytotals: widget.expenseCategorytotals, 
                isExpense: _selectedOption == 0, 
                incomeCategorytotals: widget.incomeCategorytotals ,
                ),
                 const SizedBox(
                height: 20,
              ),
              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final category = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: category.name, 
                      amount: total, 
                      total: data.values.reduce((value, element) => value + element), 
                      progressColor: getCategoryColor(category), 
                      isExpense: _selectedOption == 0,
                      );
                  }),
              )
          ],
        ),
      ),),
    );
  }
}