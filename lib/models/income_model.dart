import 'package:flutter/widgets.dart';

enum IncomeCategory {
  freelance,
  salary,
  passive,
  sales,
}

// category images
final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.freelance : "asset/images/freelance.png",
  IncomeCategory.passive : "asset/images/income.png",
  IncomeCategory.salary : "asset/images/bill.png",
  IncomeCategory.sales : "asset/images/salary.png",
};

//Category colors
final Map<IncomeCategory, Color> incomeCategoryColor = {
  IncomeCategory.freelance: const Color.fromARGB(255, 224, 67, 67),
  IncomeCategory.passive: const Color.fromARGB(255, 17, 184, 53),
  IncomeCategory.sales: const Color.fromARGB(255, 14, 201, 207),
  IncomeCategory.salary: const Color.fromARGB(255, 213, 228, 14),
};

class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.time, 
    required this.description
    });

    //convert the Income bject to json object
    Map<String, dynamic> toJSON() {
      return {
        'id' : id,
        'title' : title,
        'amount' : amount,
        'category' : category.index,
        'date' : date.toIso8601String(),
        'time' : time.toIso8601String(),
        'description' : description,
      };
    }

    //create a income object from json object

    factory Income.fromJSON(Map<String, dynamic> json) {
      return Income(
        id: json['id'], 
        title: json['title'], 
        amount: json['amount'], 
        category: IncomeCategory.values[json['category']], 
        date: DateTime.parse(json['date']), 
        time: DateTime.parse(json['time']), 
        description: json['description'],
        );
    }
}