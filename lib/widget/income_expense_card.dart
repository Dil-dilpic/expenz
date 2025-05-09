import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:flutter/material.dart';

class IncomeExpenseCard extends StatefulWidget {

  final String title;
  final double amount;
  final String imageUrl;
  final Color bgColor;

  const IncomeExpenseCard({
    super.key, 
    required this.title, 
    required this.amount, 
    required this.imageUrl, 
    required this.bgColor
    });

  @override
  State<IncomeExpenseCard> createState() => _IncomeExpenseCardState();
}

class _IncomeExpenseCardState extends State<IncomeExpenseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.45,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: widget.bgColor,
        borderRadius: BorderRadius.circular(20), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.15, 
        
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(20),
              ),   
              child:Center(
                child: Image.asset(
                  widget.imageUrl,
                  width: 70,
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              children: [
                Text(widget.title,
                style: const TextStyle(
                  fontSize: 17,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "\$ ${widget.amount.toStringAsFixed(0)}",
                style: const TextStyle(
                  fontSize: 17,
                  color: kWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),

              ],
            )
          ],
          
        ),
      ),
    );
  }
}