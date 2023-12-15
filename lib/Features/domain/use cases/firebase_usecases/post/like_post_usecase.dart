import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';

import '../../../repos/firebase_repo.dart';

class LikePostUseCase {
  final FirebaseRepo repository;

  LikePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.likePost(post);
  }
}