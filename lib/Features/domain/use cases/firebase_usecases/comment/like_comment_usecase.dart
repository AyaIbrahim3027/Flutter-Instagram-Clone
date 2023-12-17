import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

import '../../../entities/comment/comment_entity.dart';

class LikeCommentUseCase {
  final FirebaseRepo repository;

  LikeCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.likeComment(comment);
  }
}