import 'package:expenz/screens/add_new_screen.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transaction_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [
      AddNewScreen(),
      HomeScreen(),
      TransactionScreen(),
      BudgetScreen(),
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