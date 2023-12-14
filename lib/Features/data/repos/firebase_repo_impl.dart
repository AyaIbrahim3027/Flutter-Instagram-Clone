import 'dart:io';

import 'package:instagram_clone/Features/data/data%20sources/remote_data_source/remote_data_source.dart';
import 'package:instagram_clone/Features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/Features/domain/repos/firebase_repo.dart';

class FirebaseRepoImpl implements FirebaseRepo {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepoImpl({required this.remoteDataSource});

  @override
  Future<void> createUser(UserEntity user) async =>
      remoteDataSource.createUser(user);

  @override
  Future<String> getCurrentUserId() async =>
      remoteDataSource.getCurrentUserId();

  @override
  Stream<List<UserEntity>> getSingleUser(String userId) =>
      remoteDataSource.getSingleUser(userId);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity user) =>
      remoteDataSource.getUsers(user);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      remoteDataSource.signInUser(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUpUser(UserEntity user) async =>
      remoteDataSource.signUpUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      remoteDataSource.updateUser(user);

  @override
  Future<String> uploadImageToStorage(
    File? file,
    bool isPost,
    String childName,
  ) async =>
      remoteDataSource.uploadImageToStorage(file, isPost, childName);
}
