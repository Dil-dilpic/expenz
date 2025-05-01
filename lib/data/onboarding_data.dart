import 'package:expenz/models/onboarding_model.dart';

class OnboardingData {
  static final List <OnboardingModel> onBoardingDataList = [

    OnboardingModel(
      title: "Gain total control of your money", 
      imagePath: "asset/images/onboard_1.png", 
      description: "Become your own money manager and make every cent count"),
    OnboardingModel(
      title: "Know where your money goes", 
      imagePath: "asset/images/onboard_2.png", 
      description: "Track your transaction easily,with categories and financial report "),
    OnboardingModel(
      title: "Planning ahead", 
      imagePath: "asset/images/onboard_3.png", 
      description: "Setup your budget for each category so you in control"),
  ];
  
}