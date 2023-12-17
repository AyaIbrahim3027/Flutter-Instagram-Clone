import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

import '../../../entities/comment/comment_entity.dart';

class UpdateCommentUseCase {
  final FirebaseRepo repository;

  UpdateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}