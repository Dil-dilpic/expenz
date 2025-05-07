import 'dart:convert';
import 'dart:math';
import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseServices {
  //expense list
  List<Expense> expensesList = [];

  //Define the key for storing expenses in shared pref
  static const String _expenseKey = 'expense';

  //Save the expense to shared preferenses
  Future<void> saveExpense(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //Convert the existing expenses to a list of expenses
      List<Expense> existingExpenseObjects = [];

      if (existingExpenses != null) {
        existingExpenseObjects =  existingExpenses.map((e) => Expense.fromJSON(json.decode(e))).toList();
      }

      //Add the new expenses to the list
      existingExpenseObjects.add(expense);

      // Convert the list of expense object back to the a list of string
      List<String> updatedExpenses = existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list ofexpense...
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message
     if (context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Expense added succesfully!"),
        duration: Duration(seconds: 2),)
      );
     }
    } catch (error) {
            //show message
     if (context.mounted){
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error on adding Expenses!"),
        duration: Duration(seconds: 2),)
      );
     }
    }
  }

  //Load the expenses from shared preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expenseKey);

    //Convert the existing expenses to a list of expenses object
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses.map((e) => Expense.fromJSON(json.decode(e))).toList();
    }

    return loadedExpenses;
  }
}