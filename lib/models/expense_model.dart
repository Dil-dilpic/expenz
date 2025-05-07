import 'package:flutter/widgets.dart';

enum Expensecategory {
  food,
  transport,
  health,
  shopping,
  subscriptions,
}

//category images
 final  Map<Expensecategory, String> expenceCategoriesImages = {
  Expensecategory.food : "asset/images/restaurant.png",
  Expensecategory.transport : "asset/images/car.png",
  Expensecategory.health : "asset/images/health.png",
  Expensecategory.shopping : "asset/images/bag.png",
  Expensecategory.subscriptions : "asset/images/bill.png",
};

//catergory colors
final Map<Expensecategory, Color> expenseCategoriesColors = {
  Expensecategory.food : const Color.fromARGB(253, 206, 38, 9),
  Expensecategory.transport : const Color.fromARGB(253, 19, 197, 72),
  Expensecategory.health : const Color.fromARGB(253, 9, 133, 190),
  Expensecategory.shopping : const Color.fromARGB(253, 96, 165, 32),
  Expensecategory.subscriptions : const Color.fromARGB(253, 113, 31, 185),
};

class Expense {
  final int id;
  final String title;
  final double amount;
  final Expensecategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense({
    required this.id, 
    required this.title, 
    required this.amount, 
    required this.category, 
    required this.date, 
    required this.time, 
    required this.description
    });

    // convert the expense object to JSON object
    Map < String , dynamic > toJSON () {
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

    //Create an expense object from a JSON object
    factory Expense.fromJSON(Map<String, dynamic> json){
      return Expense(
        id: json['id'], 
        title: json['title'], 
        amount: json['amount'], 
        category: Expensecategory.values[json['category']], 
        date: DateTime.parse(json['date']), 
        time: DateTime.parse(json['time']), 
        description: json['description'],
        );
    }
}