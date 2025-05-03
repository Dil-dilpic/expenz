import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class Wrappers extends StatefulWidget {
  final bool showMainScreen;
  const Wrappers({
    super.key, 
    required this.showMainScreen
    });

  @override
  State<Wrappers> createState() => _WrappersState();
}

class _WrappersState extends State<Wrappers> {
  @override
  Widget build(BuildContext context) {
    return widget.showMainScreen
             ? const MainScreen()
             : const OnboardingScreen();
  }
}