import '../../../entities/user/user_entity.dart';
import '../../../repos/firebase_repo.dart';

class UpdateUserUseCase {
  final FirebaseRepo repository;

  UpdateUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.updateUser(userEntity);
  }
}