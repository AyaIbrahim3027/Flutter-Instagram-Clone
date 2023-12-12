import '../../../repos/firebase_repo.dart';

class IsSignInUseCase {
  final FirebaseRepo repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}