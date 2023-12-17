import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

import '../../../entities/comment/comment_entity.dart';

class DeleteCommentUseCase {
  final FirebaseRepo repository;

  DeleteCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.deleteComment(comment);
  }
}