import 'package:expenz/screens/onboarding/user_services.dart';  
import 'package:expenz/widget/wrappers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserServices.checkUsername(),
      builder: (context, snapshot) {
       // if the snapshot is still waiting
       if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); 
       } else {
        // here the username
        bool hasUserName = snapshot.data ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Inter",
          ),
          home: Wrappers(showMainScreen: hasUserName),
        );
       }
      },
      );
  }
}