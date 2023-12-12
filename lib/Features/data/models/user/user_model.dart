import 'package:instagram_clone/Features/domain/entities/user/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends UserEntity {
  final String? userId;
  final String? userName;
  final String? name;
  final String? bio;
  final String? website;
  final String? email;
  final String? profileUrl;
  final List? followers;
  final List? following;
  final num? totalFollowers;
  final num? totalFollowing;
  final num? totalPosts;

  const UserModel({
    this.userId,
    this.userName,
    this.name,
    this.bio,
    this.website,
    this.email,
    this.profileUrl,
    this.followers,
    this.following,
    this.totalFollowers,
    this.totalFollowing,
    this.totalPosts,

  }) : super(
    userId: userId,
    following: following,
    totalFollowing: totalFollowing,
    followers:followers,
    totalFollowers: totalFollowers,
    userName: userName,
    profileUrl: profileUrl,
    website: website,
    name: name,
    bio: bio,
    email: email,
    totalPosts: totalPosts,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;

    return UserModel(
      email: snapshot['email'],
      name: snapshot['name'],
      bio: snapshot['bio'],
      userName: snapshot['userName'],
      totalFollowers: snapshot['totalFollowers'],
      totalFollowing: snapshot['totalFollowing'],
      userId: snapshot['userId'],
      website: snapshot['website'],
      profileUrl: snapshot['profileUrl'],
      totalPosts: snapshot['totalPosts'],
      followers: List.from(snap.get('followers')),
      following: List.from(snap.get('following')),
    );
  }

  Map<String,dynamic> tpJson() => {
    "userId": userId,
    "email": email,
    "name": name,
    "userName": userName,
    "totalFollowers": totalFollowers,
    "totalFollowing": totalFollowing,
    "totalPosts": totalPosts,
    "website": website,
    "bio": bio,
    "profileUrl": profileUrl,
    "followers": followers,
    "following": following,
  };
}
