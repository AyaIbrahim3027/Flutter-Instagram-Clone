import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/create_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/like_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/read_posts_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/update_post_usecase.dart';
import '../../../domain/entities/posts/post_entity.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({
    required this.createPostUseCase,
    required this.deletePostUseCase,
    required this.likePostUseCase,
    required this.readPostsUseCase,
    required this.updatePostUseCase,
  }) : super(PostInitial());

  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostsUseCase readPostsUseCase;
  final UpdatePostUseCase updatePostUseCase;

  // read posts
  Future<void> getPosts({required PostEntity post}) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostsUseCase.call(post);
      streamResponse.listen((posts) {
        emit(PostLoaded(posts: posts));
      });
    } on SocketException catch (e) {
      emit(PostFailure());
    } catch (e) {
      emit(PostFailure());
    }
  }

  Future<void> createPost({required PostEntity post}) async {
    try {
      await createPostUseCase.call(post);
    } on SocketException catch (e) {
      emit(PostFailure());
    } catch (e) {
      emit(PostFailure());
    }
  }

  Future<void> likePost({required PostEntity post}) async {
    try {
      await likePostUseCase.call(post);
    } on SocketException catch (e) {
      emit(PostFailure());
    } catch (e) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost({required PostEntity post}) async {
    try {
      await deletePostUseCase.call(post);
    } on SocketException catch (e) {
      emit(PostFailure());
    } catch (e) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost({required PostEntity post}) async {
    try {
      await updatePostUseCase.call(post);
    } on SocketException catch (e) {
      emit(PostFailure());
    } catch (e) {
      emit(PostFailure());
    }
  }
}
