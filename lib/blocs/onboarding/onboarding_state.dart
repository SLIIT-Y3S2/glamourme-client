part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {
  late int index;
}

class OnBoardingInitialState extends OnboardingState {
  final int index = 0;
  OnBoardingInitialState();
}

class OnBoardingNextState extends OnboardingState {
  final int index;
  OnBoardingNextState({required this.index});
}

class OnBoardingPreviousState extends OnboardingState {
  final int index;
  OnBoardingPreviousState({required this.index});
}
