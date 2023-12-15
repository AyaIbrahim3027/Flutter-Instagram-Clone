import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';

import '../../../repos/firebase_repo.dart';

class UpdatePostUseCase {
  final FirebaseRepo repository;

  UpdatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.updatePost(post);
  }
}