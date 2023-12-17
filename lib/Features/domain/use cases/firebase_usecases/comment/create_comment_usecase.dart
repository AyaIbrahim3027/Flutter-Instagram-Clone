import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

import '../../../entities/comment/comment_entity.dart';

class CreateCommentUseCase {
  final FirebaseRepo repository;

  CreateCommentUseCase({required this.repository});

  Future<void> call(CommentEntity comment) {
    return repository.createComment(comment);
  }
}