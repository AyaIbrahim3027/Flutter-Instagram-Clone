import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

class GetCurrentUserIdUseCase {
  final FirebaseRepo repository;

  GetCurrentUserIdUseCase({required this.repository});

  Future<String> call() {
    return repository.getCurrentUserId();
  }
}