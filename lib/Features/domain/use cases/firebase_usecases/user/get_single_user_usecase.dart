import '../../../entities/user/user_entity.dart';
import '../../../repos/firebase_repo.dart';

class GetSingleUserUseCase {
  final FirebaseRepo repository;

  GetSingleUserUseCase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUser(uid);
  }
}