import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/Features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/sign_up_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  CredentialCubit(
      {required this.signInUserUseCase, required this.signUpUseCase})
      : super(CredentialInitial());

  final SignInUserUseCase signInUserUseCase;
  final SignUpUseCase signUpUseCase;

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(CredentialLoading());
    try {
      await signInUserUseCase
          .call(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } on SocketException catch (e) {
      emit(CredentialFailure());
    } catch (e) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser(
      {required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase
          .call(user);
      emit(CredentialSuccess());
    } on SocketException catch (e) {
      emit(CredentialFailure());
    } catch (e) {
      emit(CredentialFailure());
    }
  }
}
