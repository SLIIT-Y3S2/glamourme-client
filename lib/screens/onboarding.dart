import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter_app/data/onboarding_data_set.dart';
import 'package:flutter_app/widgets/onboarding_content.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
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
    );
  }
}
