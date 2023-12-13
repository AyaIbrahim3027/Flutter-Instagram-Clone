import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/get_current_userid_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.signOutUseCase,
    required this.isSignInUseCase,
    required this.getCurrentUserIdUseCase,
  }) : super(AuthInitial());

  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;

  Future<void> appStarted(BuildContext context) async {
    try {
      bool isSignIn = await isSignInUseCase.call();
      if (isSignIn == true) {
        final userId = await getCurrentUserIdUseCase.call();
        emit(Authenticated(userId: userId));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final userId = await getCurrentUserIdUseCase.call();
      emit(Authenticated(userId: userId));
    } catch (e) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } catch (e) {
      emit(UnAuthenticated());
    }
  }
}
