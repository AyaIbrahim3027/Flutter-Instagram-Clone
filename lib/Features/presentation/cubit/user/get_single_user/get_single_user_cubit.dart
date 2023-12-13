import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/get_single_user_usecase.dart';

import '../../../../domain/entities/user/user_entity.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  GetSingleUserCubit({required this.getSingleUserUseCase}) : super(GetSingleUserInitial());
  final GetSingleUserUseCase getSingleUserUseCase;

  Future<void> getSingleUser({required String userId}) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase.call(userId);
      streamResponse.listen((users) {
        emit(GetSingleUserLoaded(user: users.first));
      });
    } on SocketException catch (e) {
      emit(GetSingleUserFailure());
    } catch (e){
      emit(GetSingleUserFailure());
    }
  }
}
