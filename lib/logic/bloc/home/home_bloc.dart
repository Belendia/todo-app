import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';
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

    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);

      switch (result) {
        case UserCreationResult.success:
          emit(SuccessfulLoginState(event.username));
          break;
        case UserCreationResult.failure:
          emit(const HomeInitial(error: "There's been an error"));
          break;
        case UserCreationResult.alreadyExists:
          emit(const HomeInitial(error: "User already exists"));
          break;
      }

      // for successive login requests
      emit(const HomeInitial());
    });
  }
}
