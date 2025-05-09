import 'package:expenz/screens/onboarding/user_services.dart';
import 'package:expenz/screens/onboarding_screen.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constant.dart';
import 'package:expenz/widget/profile_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String userName = "";
  String email = "";

  @override
  void initState() {
   UserServices.getUserData().then((value) {
    if (value['userName'] != null && value['email'] != null) {
      setState(() {
      userName = value['userName']!;
      email = value['email']!;
      });
    }
   });
    super.initState();
  }

  // open scaffold messenger to lg out

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context, 
      builder: (context) {
        return Container(
          height: 200,
          padding:const EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Are you sure want to logOut?",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: kBlack,
              ),),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kRed),
                  ),
                  onPressed: () async {
                    // clear the user data
                    await UserServices.clearUserData();
                   if (context.mounted) {
                      // clear all expenses
                    await ExpenseServices().deleteAllExpenses(context);
                    //clear all incomes
                    await IncomeServices().deleteAllIncome(context);

                    // navigate to the onboarding screens
                   Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(
                      builder: (context) =>  OnboardingScreen(),
                      ),
                      (route) => false,
                      );
                   }

                   
                  }, 
                  child: const Text("Yes",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 18,
                fontWeight: FontWeight.w500,
                  ),),),
                  ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kGreen),
                  ),
                  onPressed: () {}, 
                  child: const Text("No",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 18,
                fontWeight: FontWeight.w500,
                  ),),)
                ],
              ),
            ],
          ),
        );
      },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body :SafeArea(
      child: SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kMainColor,
                      border: Border.all(
                        color: kMainColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "asset/images/user.jpg",
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome $userName",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      ),
                      Text(
                      email,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kGrey,
                      ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kMainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: kMainColor,
                      size: 30,
                    ),
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              ProfileCard(
                icon: Icons.wallet, 
                title: "My Wallet", 
                color: kMainColor,),
                ProfileCard(
                icon: Icons.settings, 
                title: "Settings", 
                color: kYellow,),
                ProfileCard(
                icon: Icons.download, 
                title: "Export Data", 
                color: kGreen,),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                  icon: Icons.logout, 
                  title: "Logout", 
                  color: kRed,),
                ),
              
            ],
          ),
        ),
      ))
    );
  }
}