import '../../../entities/user/user_entity.dart';
import '../../../repos/firebase_repo.dart';

class GetUsersUseCase {
  final FirebaseRepo repository;

  GetUsersUseCase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity userEntity) {
    return repository.getUsers(userEntity);
  }
}