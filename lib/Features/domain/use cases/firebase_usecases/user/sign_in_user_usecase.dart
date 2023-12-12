import '../../../entities/user/user_entity.dart';
import '../../../repos/firebase_repo.dart';

class SignInUserUseCase {
  final FirebaseRepo repository;

  SignInUserUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}