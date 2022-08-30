import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/services/authentication.dart';
import '../../../data/services/todo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  // for service initialization
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(user));
        // for successive login requests
        emit(const HomeInitial());
      }
    });

    on<RegisterServiceEvent>((event, emit) async {
      await _auth.init();
      await _todo.init();

      emit(const HomeInitial());
    });
  }
}
