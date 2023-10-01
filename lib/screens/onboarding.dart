import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter_app/data/onboarding_data_set.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/signup_screen.dart';
import 'package:flutter_app/widgets/onboarding_content.dart';
import 'package:flutter_app/widgets/page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnboardingBloc _onBoardingBloc;
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _onBoardingBloc = BlocProvider.of<OnboardingBloc>(context);
    _pageController = PageController(initialPage: 0);
  }

  //Swipe Logic for OnBoarding Screen
  void _onSwipe(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (_currentIndex < index) {
      if (_currentIndex < onBoardingData.length - 1) {
        _onBoardingBloc.add(OnBoardingNextEvent(index: _currentIndex));
        _pageController.nextPage(
            duration: const Duration(microseconds: 300),
            curve: Curves.easeInOut);
      }
    } else if (_currentIndex > index) {
      if (_currentIndex < onBoardingData.length - 1) {
        _onBoardingBloc.add(OnBoardingPreviousEvent(index: _currentIndex));
        _pageController.previousPage(
          duration: const Duration(microseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            _currentIndex = state.index;
            return PageView.builder(
              controller: _pageController,
              itemCount: onBoardingData.length,
              onPageChanged: (index) {
                if (index <= onBoardingData.length - 1) {
                  state.index = index;
                  _onSwipe(index);
                }
              },
              itemBuilder: (context, index) {
                return OnBoardingContent(
                  currentIndex: index,
                );
              },
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    onBoardingData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: PageIndicator(
                        isActive: index == _currentIndex,
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
                  const SizedBox(height: 50)
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
