import '../../../repos/firebase_repo.dart';

class SignOutUseCase {
  final FirebaseRepo repository;

  SignOutUseCase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}