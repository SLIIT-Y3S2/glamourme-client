part of 'salons_bloc.dart';

sealed class SalonsState extends Equatable {
  const SalonsState();

  @override
  List<Object> get props => [];
}

final class SalonsInitial extends SalonsState {}

final class LoadingSalons extends SalonsState {}

final class SalonsLoaded extends SalonsState {
  final List<SalonModel> salons;

  const SalonsLoaded(this.salons);

  @override
  List<Object> get props => [salons];
}
