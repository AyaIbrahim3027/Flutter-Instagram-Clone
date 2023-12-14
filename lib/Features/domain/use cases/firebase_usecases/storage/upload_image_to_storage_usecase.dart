import 'dart:io';
import '../../../repos/firebase_repo.dart';

class UploadImageToStorageUseCase {
  final FirebaseRepo repository;

  UploadImageToStorageUseCase({required this.repository});

  Future<String> call(File file,bool isPost, String childName) {
    return repository.uploadImageToStorage(file, isPost, childName);
  }
}