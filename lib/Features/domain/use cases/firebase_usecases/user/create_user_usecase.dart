import '../../../entities/user/user_entity.dart';
import '../../../repos/firebase_repo.dart';

class CreateUserUseCase {
  final FirebaseRepo repository;

  CreateUserUseCase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.createUser(user);
  }
}