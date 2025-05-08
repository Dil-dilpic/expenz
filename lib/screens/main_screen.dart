import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // index track
  int _currentPageIndex = 0 ;
  
  List<Expense> expensesList = [];
  List<Income> incomeList = [];

  //Function to fetch expense
  void fetchAllExpenses() async {
    List<Expense> loadExpenses = await ExpenseServices().loadExpenses();
    setState(() {
      expensesList = loadExpenses;

    });
  }

  //Function to fetch all incomes
  void fetchAllIncomes() async {
    List <Income> loadedIncome = await IncomeServices().loadIncomes();
    setState(() {
      incomeList = loadedIncome;
    });
  }

  // Function to add new expenses
  void addNewExpense(Expense newExpense) {
    ExpenseServices().saveExpense(newExpense, context);

    //Update the list of expenses
    setState(() {
      expensesList.add(newExpense);
    });
  }

  //Function to add new income
  void addNewIncome (Income newIncome) {
    IncomeServices().saveIncome(newIncome, context);

   //Updated the income list
   setState(() {
     incomeList.add(newIncome);

   }); 
  }

  //Function to remove a expense
  void removeExpense(Expense expense) {
    ExpenseServices().deleteExpense(expense.id, context);
    setState(() {
      expensesList.remove(expense);
    });
  }

  //Function to remove a Income
   void removeIncome(Income income) {
    IncomeServices().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  //Catergory Totall expenses
  Map<Expensecategory, double> calculateExpenseCatergories () {
    Map<Expensecategory, double> catergoryTotals = {
      Expensecategory.food : 0,
      Expensecategory.health : 0,
      Expensecategory.shopping : 0,
      Expensecategory.subscriptions : 0,
      Expensecategory.transport : 0,
    };

    for( Expense expense in expensesList) {
      catergoryTotals[expense.category] = 
        catergoryTotals[expense.category]! + expense.amount;
    }

    return catergoryTotals;
  }

   //Catergory Totall incomes
  Map<IncomeCategory, double> calculateIncomeCatergories () {
    Map<IncomeCategory, double> catergoryTotals = {
     IncomeCategory.freelance : 0,
     IncomeCategory.passive : 0,
     IncomeCategory.salary : 0,
     IncomeCategory.sales : 0,
    };

    for (Income income in incomeList) {
      catergoryTotals[income.category] = 
          catergoryTotals[income.category]! + income.amount;
    }
    return catergoryTotals;
  }





  @override
  void initState() {    
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }
  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [     
      
      HomeScreen(
        expenseList: expensesList,
        incomeList: incomeList,
      ),
      TransactionScreen(
        expenseList: expensesList,
        onDismissedExpense: removeExpense,
        onDismissedIncome: removeIncome,
        incomeList: incomeList,
      ),
      AddNewScreen(
        addExpens: addNewExpense,
        addIncome: addNewIncome,
      ),
      BudgetScreen(
        expenseCategorytotals: calculateExpenseCatergories(),
        incomeCategorytotals: calculateIncomeCatergories(),
      ),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;

          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.list_rounded),
          label: "Transaction",
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: kMainColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: kWhite,
              size: 30,),
              ),
          label: "Add",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.rocket),
          label: "Budget",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ]),
        body: pages[_currentPageIndex],     
    );
  }
}