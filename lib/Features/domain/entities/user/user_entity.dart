import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? userId;
  final String? userName;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? follower;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;

  // will not going to store in DB
  final String? password;
  final String? otherUserId;

  const UserEntity({
    this.userId,
    this.userName,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.follower,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.password,
    this.otherUserId,
  });

  @override
  List<Object?> get props => [
    userId,
    userName,
    name,
    bio,
    website,
    email,
    profileUrl,
    follower,
    following,
    totalFollowers,
    totalFollowing,
    password,
    otherUserId,
  ];
}
