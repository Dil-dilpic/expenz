import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<Expensecategory, double> expenseCategorytotals;
  final Map<IncomeCategory, double> incomeCategorytotals;
  final bool isExpense;
  const Chart({
    super.key, 
    required this.expenseCategorytotals, 
    required this.incomeCategorytotals, 
    required this.isExpense,
    });

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  //section data
  List<PieChartSectionData> getsections() {
    if (widget.isExpense) {
      return[
        PieChartSectionData(
          color: expenseCategoriesColors[Expensecategory.food],
          value: widget.expenseCategorytotals[Expensecategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenseCategoriesColors[Expensecategory.food],
          value: widget.expenseCategorytotals[Expensecategory.food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenseCategoriesColors[Expensecategory.health],
          value: widget.expenseCategorytotals[Expensecategory.health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenseCategoriesColors[Expensecategory.shopping],
          value: widget.expenseCategorytotals[Expensecategory.shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenseCategoriesColors[Expensecategory.subscriptions],
          value: widget.expenseCategorytotals[Expensecategory.subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: expenseCategoriesColors[Expensecategory.transport],
          value: widget.expenseCategorytotals[Expensecategory.transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }else {
      return[
         PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.freelance],
          value: widget.incomeCategorytotals[IncomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.passive],
          value: widget.incomeCategorytotals[IncomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.salary],
          value: widget.incomeCategorytotals[IncomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
         PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.sales],
          value: widget.incomeCategorytotals[IncomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }
  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getsections(),
      borderData: FlBorderData(show: false)
    );
    return Container(
      height: 250,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("70%",
              style: TextStyle(
                color: kBlack,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(
                height: 8,
              ),
              Text("of 100%",
              style: TextStyle(
                color: kGrey,
              ),)
            ],
          )
        ],
      ),
    );
  }
}