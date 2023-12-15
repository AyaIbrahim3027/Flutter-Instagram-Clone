import 'package:instagram_clone/Features/domain/entities/posts/post_entity.dart';

import '../../../repos/firebase_repo.dart';

class ReadPostsUseCase {
  final FirebaseRepo repository;

  ReadPostsUseCase({required this.repository});

  Stream<List<PostEntity>> call(PostEntity post) {
    return repository.readPosts(post);
  }
}