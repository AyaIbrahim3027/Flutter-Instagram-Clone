import '../../../entities/user/user_entity.dart';
import '../../../repos/firebase_repo.dart';

class SignUpUseCase {
  final FirebaseRepo repository;

  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signUpUser(userEntity);
  }
}