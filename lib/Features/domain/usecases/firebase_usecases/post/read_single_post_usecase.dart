import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/repos/firebase_repository.dart';

class ReadSinglePostUseCase {
  final FirebaseRepository repository;

  ReadSinglePostUseCase({required this.repository});

  Stream<List<PostEntity>> call(String postId) {
    return repository.readSinglePost(postId);
  }
}