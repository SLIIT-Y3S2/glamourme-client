part of 'salons_bloc.dart';

sealed class SalonsEvent extends Equatable {
  const SalonsEvent();

  @override
  List<Object> get props => [];
}

class GetSalonsEvent extends SalonsEvent {
  const GetSalonsEvent();
}
