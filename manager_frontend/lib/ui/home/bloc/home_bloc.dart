import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

enum FragmentType {
  profileFragment,
  employeesFragment,
  departmentsFragment,
  stationsFragment,
  routesFragment,
  trainsFragment,
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(currentFragment: FragmentType.profileFragment)) {
    on<SwitchFragment>((event, emit) {
      emit(state.copyWith(currentFragment: event.fragmentType));
    });
  }
}
