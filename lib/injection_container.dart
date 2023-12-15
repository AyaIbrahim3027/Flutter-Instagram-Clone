import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/Features/data/data%20sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_clone/Features/data/data%20sources/remote_data_source/remote_data_source_impl.dart';
import 'package:instagram_clone/Features/data/repos/firebase_repo_impl.dart';
import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';
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
import 'package:instagram_clone/Features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/Features/presentation/cubit/user/user_cubit.dart';

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

  // Use cases
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
