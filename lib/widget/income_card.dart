import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final IncomeCategory category;
  final String description;
  final DateTime time;

  const IncomeCard({
    super.key, 
    required this.title, 
    required this.date, 
    required this.amount, 
    required this.category, 
    required this.description, 
    required this.time
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1)
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: incomeCategoryColor[category]!.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                incomeCategoryImages[category]!,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
            title,
            style: 
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kBlack,),
              ),
              SizedBox(height: 2,),
              SizedBox(
                width: 100,
                child: Text(
                            description,
                            style: 
                            TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: kGrey,),
                overflow: TextOverflow.ellipsis,
                ),
              ),
          ],

          ),
          const Spacer(),
           Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Text(
            "+\$${amount.toStringAsFixed(2)}",
            style: 
            TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: kGreen,),
              ),
              SizedBox(height: 2,),
              Text(
            DateFormat.jm().format(date),
            style: 
            TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kGrey,),
              ),
          ],

          )
        ],
      ),
    );
  }
}