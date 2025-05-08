import 'dart:convert';
import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeServices {
  // Define the key for storing income in shared preferences
  static const String _incomeKey = 'income';

  //Save the income to shared preferences
  Future <void> saveIncome (Income income , BuildContext context) async {

    try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List <String>? existingIncome = prefs.getStringList(_incomeKey);

    // Convert the existing incomes to a list of income object
    List<Income> existingIncomeObjects = [];

    if (existingIncome != null) {
      existingIncome.map((e) => Income.fromJSON(json.decode(e))).toList();
    }

    //Add the new income to list
    existingIncomeObjects.add(income);

    //Convert the list of income object back to the list of income string
    List<String> updatedIncome = 
      existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

     // Save the updated list of income to shared preferences
     await prefs.setStringList(_incomeKey, updatedIncome);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Income added successfully!"),
        duration: Duration(seconds: 2),
      ),
     );
    }
    } catch (error) {
       if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Error an adding Income!"),
        duration: Duration(seconds: 2),
      ),
     );
    }
    }
    
  }
  //Load the income from shared preferences
  Future <List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List <String>? existingIncome = pref.getStringList(_incomeKey);

    //Convert the Existing incomes to a list of incoe object
    List<Income> loadIncomes = [];
    if (existingIncome != null) {
      loadIncomes = 
          existingIncome.map((e) => Income.fromJSON(json.decode(e))).toList();
    }
    return loadIncomes;
  }

  // Function to delete an income
  Future <void> deleteIncome (int id , BuildContext context) async {
    
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncome = prefs.getStringList(_incomeKey);
  
  //convert the existing income to a list of income object
  List<Income> existingIncomeObjects = [];
  if (existingIncome != null) {
    existingIncomeObjects = 
      existingIncome.map((e) => Income.fromJSON(json.decode(e))).toList();
  }

  //Remove the income with the givenid from the list
  existingIncomeObjects.removeWhere((income) => income.id == id);

  //Convert the list of Income objects back to a list of string
  List<String> updatedIncomes = 
      existingIncomeObjects.map((e) => json.encode(e.toJSON())).toList();

   //Save the updated list of income to shared prefers
   await prefs.setStringList(_incomeKey, updatedIncomes);

   //show message
   if (context.mounted) {
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Income deleted successfully!"),
        duration: Duration(seconds: 2),
      ),
     );
   } 
    } catch (error) {
       //show message
   if (context.mounted) {
     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("erro income deleting!"),
        duration: Duration(seconds: 2),
      ),
     );
   } 
    }
      
  }
}