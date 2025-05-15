import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  EmployeesBloc() : super(EmployeesInitial()) {
    on<EmployeesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
