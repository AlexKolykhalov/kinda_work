part of 'transition_bloc.dart';

@immutable
abstract class TransitionState {}

class TransitionInitial extends TransitionState {}

class TransitionLoading extends TransitionState {}

class TransitionLoaded extends TransitionState {}
