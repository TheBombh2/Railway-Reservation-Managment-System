part of 'home_bloc.dart';

final class HomeState {
  final FragmentType currentFragment;
  HomeState({required this.currentFragment});

 HomeState copyWith({
    FragmentType? currentFragment,
  }) {
    return HomeState(
      currentFragment: currentFragment ?? this.currentFragment
    );
  }
}
