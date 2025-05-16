part of 'home_bloc.dart';

abstract class HomeEvent {}

class SwitchFragment extends HomeEvent{
  final FragmentType fragmentType;
  SwitchFragment(this.fragmentType);
}
