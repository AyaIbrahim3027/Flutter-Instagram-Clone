import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/Features/data/data%20sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_clone/Features/data/data%20sources/remote_data_source/remote_data_source_impl.dart';
import 'package:instagram_clone/Features/data/repos/firebase_repo_impl.dart';
import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/create_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/like_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/read_posts_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/post/update_post_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/get_current_userid_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/get_users_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'package:instagram_clone/Features/domain/use%20cases/firebase_usecases/user/update_user_usecase.dart';
import 'package:instagram_clone/Features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/comment/comment_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/user_cubit.dart';

import 'Features/domain/use cases/firebase_usecases/comment/create_comment_usecase.dart';
import 'Features/domain/use cases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'Features/domain/use cases/firebase_usecases/comment/like_comment_usecase.dart';
import 'Features/domain/use cases/firebase_usecases/comment/read_comment_usecase.dart';
import 'Features/domain/use cases/firebase_usecases/comment/update_comment_usecase.dart';
import 'Features/domain/use cases/firebase_usecases/user/create_user_usecase.dart';

final sl = GetIt.instance; // sl == service locator

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => AuthCubit(
        signOutUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        getCurrentUserIdUseCase: sl.call(),
      ));

  sl.registerFactory(() => CredentialCubit(
        signInUserUseCase: sl.call(),
        signUpUseCase: sl.call(),
      ));

  sl.registerFactory(() => UserCubit(
        updateUserUseCase: sl.call(),
        getUsersUseCase: sl.call(),
      ));

  sl.registerFactory(() => GetSingleUserCubit(
        getSingleUserUseCase: sl.call(),
      ));

  // Post cubit
  sl.registerFactory(() => PostCubit(
        createPostUseCase: sl.call(),
        deletePostUseCase: sl.call(),
        likePostUseCase: sl.call(),
        readPostsUseCase: sl.call(),
        updatePostUseCase: sl.call(),
      ));

  // Comment cubit
  sl.registerFactory(() => CommentCubit(
        createCommentUseCase: sl.call(),
        deleteCommentUseCase: sl.call(),
        likeCommentUseCase: sl.call(),
        readCommentsUseCase: sl.call(),
        updateCommentUseCase: sl.call(),
      ));

  // Use cases
  // User
  sl.registerLazySingleton(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton(
      () => GetCurrentUserIdUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => CreateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(repository: sl.call()));

  // Cloud Storage
  sl.registerLazySingleton(
      () => UploadImageToStorageUseCase(repository: sl.call()));

  // Post
  sl.registerLazySingleton(() => CreatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadPostsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUseCase(repository: sl.call()));

  // Comment
  sl.registerLazySingleton(() => CreateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadCommentsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepo>(() => FirebaseRepoImpl(
        remoteDataSource: sl.call(),
      ));

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(
            firebaseFirestore: sl.call(),
            firebaseAuth: sl.call(),
            firebaseStorage: sl.call(),
          ));

  // Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
