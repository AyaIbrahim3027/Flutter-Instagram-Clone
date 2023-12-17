import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

import '../../../entities/comment/comment_entity.dart';

class ReadCommentsUseCase {
  final FirebaseRepo repository;

  ReadCommentsUseCase({required this.repository});

  Stream<List<CommentEntity>> call(String postId) {
    return repository.readComments(postId);
  }
}