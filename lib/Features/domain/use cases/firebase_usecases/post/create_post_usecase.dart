import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';

import '../../../repos/firebase_repo.dart';

class CreatePostUseCase {
  final FirebaseRepo repository;

  CreatePostUseCase({required this.repository});

  Future<void> call(PostEntity post) {
    return repository.createPost(post);
  }
}