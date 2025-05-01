import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
 // page controleer
 final PageController _controller = PageController();
 bool showDetailPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // onboarding screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailPage = index ==3;
                    });
                  },

                  children: [
                    FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onBoardingDataList[0].title, 
                      imagePath: OnboardingData.onBoardingDataList[0].imagePath, 
                      description: OnboardingData.onBoardingDataList[0].description,
                      ),
                      SharedOnboardingScreen(
                      title: OnboardingData.onBoardingDataList[1].title, 
                      imagePath: OnboardingData.onBoardingDataList[1].imagePath, 
                      description: OnboardingData.onBoardingDataList[1].description,
                      ),
                      SharedOnboardingScreen(
                      title: OnboardingData.onBoardingDataList[2].title, 
                      imagePath: OnboardingData.onBoardingDataList[2].imagePath, 
                      description: OnboardingData.onBoardingDataList[2].description,
                      ),
                                                     
                  ],
                ),
                // smooth dot indicator adding
                Container(
                  alignment: Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller, 
                    count: 4,
                    effect: const ScrollingDotsEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                    ),
                ),

                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: !showDetailPage ? GestureDetector(
                      onTap: () {
                        _controller.animateToPage(
                          _controller.page!.toInt()+1,
                          duration: const Duration( milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: CustomButton(
                      buttonName: showDetailPage ? "Get started " : "Next", 
                      buttonColor: kMainColor),
                    ) : GestureDetector(
                      onTap: () {
                        // Navigate to the user data screen
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        => const UserDataScreen(),
                        ),
                        );
                      },
                      child: CustomButton(
                      buttonName: showDetailPage ? "Get started " : "Next", 
                      buttonColor: kMainColor),
                    ) ,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}