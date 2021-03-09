part of 'cards_bloc.dart';

@immutable
abstract class CardsState {}

class CardsInitial extends CardsState {}

class CardsLoading extends CardsState {}

class CardsLoaded extends CardsState {
  CardsLoaded({@required this.cards});

  final List<DiscountCard> cards;
}
