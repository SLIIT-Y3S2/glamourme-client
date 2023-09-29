import 'package:flutter/material.dart';
import 'package:flutter_app/data/onboarding_data_set.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/signup.dart';
import 'package:flutter_app/widgets/page_indicator.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //Login Button Handler
    void onClickLogin() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }

    //Get Started Button Handler
    onClickGetStarted() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        ),
      );
    }

    return SafeArea(
      top: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //Background Image
          Image.asset(
            onBoardingData[currentIndex].image,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          //Background Tint
          Container(
            color: Colors.black54,
          ),
          //Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  onBoardingData[currentIndex].text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.25,
                      ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    onBoardingData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: PageIndicator(
                        isActive: index == currentIndex,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: onClickLogin,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  const SizedBox(
                    width: 70,
                  ),
                  ElevatedButton(
                    onPressed: onClickGetStarted,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50)
            ],
          ),
        ],
      ),
    );
  }
}
