import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';

import '../../../repos/firebase_repo.dart';

class DeletePostUseCase {
  final FirebaseRepo repository;

  DeletePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.deletePost(post);
  }
}