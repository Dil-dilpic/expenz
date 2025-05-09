import 'dart:convert';
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
  // delete the expense from shared prference from the id
  Future <void> deleteExpense (int id , BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? existingExpreses = pref.getStringList(_expenseKey);

      //Convert the existing expenses to a list of expense object
      List<Expense> existingExpenseObjects = [];
      if (existingExpreses != null) {

        existingExpenseObjects = existingExpreses.map((e) => Expense.fromJSON(json.decode(e))).toList();
      }

      //Remove the expense with the specified id from the list
      existingExpenseObjects.removeWhere((expens) => expens.id == id);

      //Convert the list of expense object back to lis of string
      List<String> updatedExpenses = 
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

       //Save the updated list of expenses to shared preferences
       await pref.setStringList(_expenseKey, updatedExpenses);

       //Show snackbar
       if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Expenses delete succesfully"),
            duration: Duration(seconds: 2),
            ),
         );
       }   
    } catch (error) {
      print(error.toString());

      if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error deleting expenses"),
            duration: Duration(seconds: 2),
            ),
         );
       } 
    }
  }

  // delete all expense from shared freferdences
   Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_expenseKey);

      //show messege
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All expense deleted!"),
          duration: Duration(seconds: 2),
          ),
          );
      }
    } catch (error) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error deleting Expenses!"),
          duration: Duration(seconds: 2),
          ),
          );
      }
    }
   } 
}