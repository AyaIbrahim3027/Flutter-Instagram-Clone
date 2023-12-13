import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/get_users_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/update_user_usecase.dart';

import '../../../domain/entities/user/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.updateUserUseCase, required this.getUsersUseCase})
      : super(UserInitial());

  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;

  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase.call(user);
      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (e) {
      emit(UserFailure());
    } catch (e){
      emit(UserFailure());
    }
  }

  Future<void> updateUser({required UserEntity user}) async {
    try {
      await updateUserUseCase
          .call(user);
    } on SocketException catch (e) {
      emit(UserFailure());
    } catch (e) {
      emit(UserFailure());
    }
  }
}
